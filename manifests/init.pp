class netdata (
  String $release_version,
  String $install_dir_root,
) {

  contain netdata::install
  contain netdata::config
  contain netdata::service

}
