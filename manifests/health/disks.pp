class netdata::health::disks inherits netdata {

  if $netdata::health_disks_manage == true {
    file { "${netdata::config_dir}/health.d/disks.conf":
      ensure  => present,
      owner   => 'netdata',
      group   => 'netdata',
      mode    => '0660',
      content => template('netdata/health.d/disks.conf.erb'),
      notify  => Exec['netdata-restart-alarms'],
      require => File[$netdata::config_dir],
    }
  }
}
