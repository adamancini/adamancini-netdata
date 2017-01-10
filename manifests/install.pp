class netdata::install inherits netdata {

  $installation_source = "https://github.com/firehol/netdata/releases/download/v${netdata::release_version}/netdata-${netdata::release_version}.tar.gz"

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

  exec { "Download netdata-${netdata::release_version}":
    command => "/usr/bin/wget -qO- ${installation_source} | tar xvz -C /root/",
    creates => "/root/netdata-${netdata::release_version}",
    before  => Exec['Install netdata']
  }

  exec { 'Install netdata':
    command => "/root/netdata-${netdata::release_version}/netdata-installer.sh",
    cwd     => "/root/netdata-${netdata::release_version}",
    creates => '/etc/netdata',
  }

  case $netdata::service_provider {
    'init.d': {
      exec { 'Install init.d service file':
        command => "cp /root/netdata/${netdata::service_file} ./netdata",
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
}
