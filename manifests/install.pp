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

  vcsrepo { 'netdata_repo':
    ensure   => $netdata::repo_ensure,
    provider => git,
    path     => $netdata::repo_location,
    source   => $netdata::installation_source,
  }

  exec { 'Install_netdata':
    command     => "${netdata::repo_location}/netdata-installer.sh",
    cwd         => $netdata::repo_location,
    creates     => $netdata::config_dir,
    subscribe   => Vcsrepo['netdata_repo'],
    refreshonly => true,
  }
}
