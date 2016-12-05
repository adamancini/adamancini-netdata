class netdata (
  String $release_version,
  String $install_dir_root,
  String $config_file_path,
  String $config_file_template,
) {

  require ::archive

  contain netdata::install
  contain netdata::config
  contain netdata::service

}
