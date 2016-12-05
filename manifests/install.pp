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
    'tc',
    'python',
    'python-yaml',
    'python-mysqldb',
    'python-psycopg2',
    'nodejs',
    'lm_sensors',
    'libmnl',
    'netcat'
  ]

  ensure_packages( $build_deps, {'ensure' => 'present'} )
  ensure_packages( $plugin_deps, {'ensure' => 'present'} )

  # archive { "/tmp/netdata-${netdata::release_version}.tar.gz":
  #   ensure       => present,
  #   extract      => true,
  #   extract_path => '/tmp',
  #   source       => "https://github.com/firehol/netdata/releases/download/v${netdata::release_version}/netdata-${netdata::release_version}.tar.gz",
  #   creates      => "/tmp/netdata-${netdata::release_version}",
  #   cleanup      => true,
  #   before       => Exec['Install netdata']
  # }

  exec { "Download netdata-${netdata::release_version}":
    command => "wget https://github.com/firehol/netdata/releases/download/v${netdata::release_version}/netdata-${netdata::release_version}.tar.gz -O /root/netdata-${netdata::release_version}",
    creates => "/root/netdata-${netdata::release_version}",
    before  => Exec['Install netdata']
  }

  exec { 'Install netdata':
    command => "/root/netdata-${netdata::release_version}/netdata-installer.sh --install ${netdata::install_dir_root}",
    creates => '/etc/netdata/netdata.conf',
  }
}
