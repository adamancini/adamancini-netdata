class netdata::service inherits netdata {

  if $netdata::service_manage == true {

    if ! ($netdata::service_ensure in [ 'running', 'stopped' ]) {
      fail('service_ensure parameter must be running or stopped')
    }

    service { 'netdata':
      ensure     => $netdata::service_ensure,
      enable     => $netdata::service_enable,
      name       => $netdata::service_name,
      provider   => $netdata::service_provider,
      subscribe  => File['netdata config file'],
      hasstatus  => true,
      hasrestart => true,
    }

    exec { 'netdata-restart-alarms':
      refreshonly => true,
      command     => '/usr/bin/killall -USR2 netdata',
    }
  }
}
