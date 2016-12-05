class netdata::config inherits netdata {

  $conf_dir = "${netdata::install_dir_root}/netdata/etc"
  # stub
  file { $conf_dir:
    ensure => present,
  }

}
