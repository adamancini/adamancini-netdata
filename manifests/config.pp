class netdata::config inherits netdata {

  $conf_dir = '/etc/netdata'
  $conf_file = "${conf_dir}/netdata.conf"
  # stub
  file { $conf_dir:
    ensure => directory,
    owner  => 'netdata',
    group  => 'netdata',
    mode   => '0755',
    before => $conf_file,
  }

  file { $conf_file:
    ensure => present,
    owner  => 'netdata',
    group  => 'netdata',
    mode   => '0664',
  }
}
