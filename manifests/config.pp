class netdata::config inherits netdata {

  if $netdata::config_manage {

    file { 'netdata config file':
      ensure => present,
      path   => $netdata::config_file,
      owner  => $netdata::service_name,
      group  => $netdata::service_name,
      mode   => '0660',
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
}
