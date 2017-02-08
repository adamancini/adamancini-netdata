class netdata (
  String $ensure
  String $release_version,
  Stdlib::Absolutepath $config_dir,
  Stdlib::Absolutepath $config_file,
  Boolean $custom_registry_enabled,
  Optional[String] $custom_registry_hostname,
  Optional[String] $custom_registry_to_announce,
  Boolean $config_manage,
  Boolean $install_dependencies,
  Boolean $install_plugin_dependencies,
  Boolean $install_jq,
  Optional[String] $install_dir_root,
  String $installation_source,
  Optional[String] $repo_location,
  Boolean $service_enable,
  String $service_ensure,
  Boolean $service_manage,
  String $service_name,
  String $service_file,
  Optional[String] $service_provider,
  Optional[Hash] $options,
  ) {

  contain netdata::install
  contain netdata::config
  contain netdata::service

  Class['::netdata::install'] ->
  Class['::netdata::config'] ~>
  Class['::netdata::service']
}
