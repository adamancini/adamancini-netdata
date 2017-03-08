class netdata::config inherits netdata {

  if $netdata::config_manage {

    file { 'netdata config file':
      ensure  => present,
      path    => $netdata::config_file,
      owner   => $netdata::service_name,
      group   => $netdata::service_name,
      mode    => '0660',
      notify  => Service['netdata'],
      require => File[$netdata::config_dir]
    }

    validate_hash($netdata::options)
    $ini_defaults = {
      'path' => $netdata::config_file,
      'ensure' => 'present',
    }
    create_ini_settings($netdata::options, $ini_defaults)
  }

  if $netdata::alarms_manage == true {
    file { 'netdata alarms notifications':
      ensure  => present,
      content => epp('netdata/health_alarm_notify.conf.epp'),
      path    => "${netdata::config_dir}/health_alarm_notify.conf",
      owner   => $netdata::service_name,
      group   => $netdata::service_name,
      mode    => '0660',
    }
  }

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

  if $netdata::health_net_manage == true {
    file { "${netdata::config_dir}/health.d/net.conf":
      ensure  => present,
      owner   => 'netdata',
      group   => 'netdata',
      mode    => '0660',
      content => template('netdata/health.d/net.conf.erb'),
      notify  => Exec['netdata-restart-alarms'],
      require => File[$netdata::config_dir],
    }
  }
}
