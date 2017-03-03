class netdata::install inherits netdata {

  $build_deps = [
    'autoconf-archive',
    'autoconf',
    'autogen',
    'automake',
    'curl',
    'gcc',
    'git',
    'libmnl-dev',
    'make',
    'pkg-config',
    'uuid-dev',
    'zlib1g-dev',
  ]

  # recommended packages for full functionality of netdata
  $plugin_deps = [
    'iproute2', # provides the 'tc' application
    'python',
    'python-yaml',
    'python-mysqldb',
    'python-psycopg2',
    'nodejs',
    'lm-sensors',
    'libmnl0',
    'netcat'
  ]

  if $netdata::install_dependencies == true {
    ensure_packages( $build_deps, {'ensure' => 'present'} )
  }

  if $netdata::install_plugin_dependencies == true {
    ensure_packages( $plugin_deps, {'ensure' => 'present'} )
  }

  if $netdata::install_jq == true {
    ensure_packages( 'jq', {'ensure' => 'present'} )
  }

  if $netdata::install_firehol == true {
    ensure_packages( 'firehol', {'ensure' => 'present'} )
  }

  if $netdata::install_from_git == true {

    $netdata_installer_path = "${netdata::source_prefix}/netdata/netdata-installer.sh"

    vcsrepo { 'netdata_git':
      ensure   => $netdata::repo_ensure,
      path     => "${netdata::source_prefix}/netdata",
      provider => git,
      source   => $netdata::git_repo,
      notify   => Exec['Install netdata'],
    }

    if $netdata::update_with_cron == true {
      cron { 'netdata-updater.sh':
        command => "${netdata::source_prefix}/netdata/netdata-updater.sh",
        hour    => $netdata::update_cron_hour,
        minute  => $netdata::update_cron_min,
        user    => $netdata::update_cron_user,
        weekday => $netdata::update_cron_weekday,
        require => Vcsrepo['netdata_git'],
      }
    }
  }
  else { # install from package tarball

    $installation_source = "https://github.com/firehol/netdata/releases/download/v${netdata::release_version}/netdata-${netdata::release_version}.tar.gz"
    $netdata_installer_path = "${netdata::source_prefix}/netdata-${netdata::release_version}/netdata-installer.sh"

    exec { "Download netdata-${netdata::release_version}":
      command => "/usr/bin/wget -qO- ${installation_source} | tar xvz -C ${netdata::source_prefix}",
      creates => "${netdata::source_prefix}/netdata-${netdata::release_version}",
      notify  => Exec['Install netdata']
    }
  }

  exec { 'Install netdata':
    command     => $netdata_installer_path,
    refreshonly => true,
    cwd         => "${netdata::source_prefix}/netdata",
    before      => File[$netdata::config_dir],
  }

  file { $netdata::config_dir:
    ensure => directory,
    owner  => 'netdata',
    group  => 'netdata',
    mode   => '0775',
  }

  case $::facts['service_provider'] {
    'systemd': {
      # systemd handled automatically
    }
    'upstart': {
      exec { 'Install netdata init file':
        command     => "cp ${netdata::source_prefix}/netdata/${netdata::service_file} ./netdata",
        cwd         => '/etc/init.d/',
        creates     => '/etc/init.d/netdata',
        before      => File['/etc/init.d/netdata'],
        subscribe   => Exec['Install netdata'],
        refreshonly => true,
      }
      file { '/etc/init.d/netdata':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '0750',
      }
    }
    default: {
      fail('Unsupported init system')
    }
  }
}
