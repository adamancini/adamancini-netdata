class netdata::health::net inherits netdata {

  if netdata::health_net_manage == true {
    file { "${netdata::config_dir}/health.d/net.conf":
      ensure  => present,
      owner   => 'netdata',
      group   => 'netdata',
      mode    => '0660',
      content => template('netdata/health.d/net.conf.erb'),
    }
  }
}
