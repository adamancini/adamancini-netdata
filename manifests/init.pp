class netdata (
  String $release_version,
  Optional[String] $install_dir_root,
  String $config_file_path,
  String $config_file_template,
) {

  contain netdata::install
  contain netdata::config
  contain netdata::service

  Class['::netdata::install'] ->
  Class['::netdata::config'] ~>
  Class['::netdata::service']

}
