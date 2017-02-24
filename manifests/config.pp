class netdata::config inherits netdata {

  if $netdata::config_manage {

    file { 'netdata config file':
      ensure => present,
      path   => $netdata::config_file,
      owner  => $netdata::service_name,
      group  => $netdata::service_name,
      mode   => '0664',
    }

    if $netdata::alarms_manage == true {
      file { 'netdata alarms notifications':
        ensure  => present,
        content => template('netdata/health_alarm_notify.conf.erb'),
        path    => $netdata::health_alarms_notify_config,
        owner   => $netdata::service_name,
        group   => $netdata::service_name,
        mode    => '0755',
      }
    }

    validate_hash($netdata::options)
    $ini_defaults = {
      'path' => $netdata::config_file,
      'ensure' => 'present',
    }
    create_ini_settings($netdata::options, $ini_defaults)
  }
}
