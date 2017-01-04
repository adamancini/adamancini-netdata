class netdata::config inherits netdata {

  $conf_dir = '/etc/netdata'
  # stub
  file { $conf_dir:
    ensure => directory,
  }
}
