class netdata::install (
  String $release_version,
  String $install_dir_root,
  ) {

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

  archive { "/tmp/netdata-${release_version}.tar.gz":
    ensure       => present,
    extract      => true,
    extract_path => '/tmp',
    source       => "https://github.com/firehol/netdata/releases/download/v${release_version}/netdata-${release_version}.tar.gz",
    creates      => "/tmp/netdata-${release_version}",
    cleanup      => true,
    before       => Exec['Install netdata']
  }

  exec { 'Install netdata':
    command => "/tmp/netdata-${release_version}/netdata-installer.sh --install ${install_dir_root}",
    creates => '/etc/netdata/netdata.conf',
  }
}
