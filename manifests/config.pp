class netdata::config inherits netdata {

  # stub
  file { $netdata::config_file_path:
    ensure => present,
  }

}
