class netdata (
  String $release_version,
  Stdlib::Absolutepath $config_dir,
  Stdlib::Absolutepath $config_file,
  Boolean $custom_registry_enabled,
  Optional[String] $custom_registry_hostname,
  Optional[String] $custom_registry_to_announce,
  Boolean $config_manage,
  Boolean $install_dependencies,
  Optional[String] $install_dir_root,
  Boolean $service_enable,
  String $service_ensure,
  Boolean $service_manage,
  String $service_name,
  Optional[String] $service_provider,
  Optional[Hash] $options,
  Boolean $webserver_manage,
  Optional[String] $webserver_class
  ) {

  contain netdata::install
  contain netdata::config
  contain netdata::service
  contain netdata::webserver

  Class['::netdata::install'] ->
  Class['::netdata::config'] ~>
  Class['::netdata::service']
}
