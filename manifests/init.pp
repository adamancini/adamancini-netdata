class netdata (
  String $release_version,
  Boolean $service_manage,
  Boolean $config_manage,
  Boolean $install_dependencies,
  ) {

  contain netdata::install
  contain netdata::config
  contain netdata::service

  Class['::netdata::install'] ->
  Class['::netdata::config'] ~>
  Class['::netdata::service']
}
