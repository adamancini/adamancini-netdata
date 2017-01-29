class netdata::install inherits netdata {

  $installation_source = 'https://github.com/firehol/netdata.git'

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
    ensure_packages( $plugin_deps, {'ensure' => 'present'} )
  }

  if $netdata::install_jq == true {
    ensure_packages( 'jq', {'ensure' => 'present'} )
  }

  vcsrepo { '/opt/netdata':
    ensure   => present,
    provider => git,
    source   => $installation_source,
    before   => Exec['Install_netdata'],
  }

  exec { 'Install_netdata':
    command => '/opt/netdata/netdata-installer.sh',
    cwd     => '/opt/netdata',
    creates => '/etc/netdata',
  }

  case $::facts['service_provider'] {
    'upstart': {
      exec { 'Install init.d/upstart compatible service file':
        command => "cp /root/netdata-${netdata::release_version}/${netdata::service_file} ./netdata",
        cwd     => '/etc/init.d/',
        creates => '/etc/init.d/netdata',
        before  => File['/etc/init.d/netdata'],
      }

      file { '/etc/init.d/netdata':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
      }
    }
    'systemd': {
      notify {"Systemd service file installed automatically": }
    }
    default: {
      notify {"Default is a noop": }
    }
  }

  file { 'netdata config file':
    ensure => file,
    path   => $netdata::config_file,
    owner  => $netdata::service_name,
    group  => $netdata::service_name,
    mode   => '0664',
  }
}
