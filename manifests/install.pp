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
}
