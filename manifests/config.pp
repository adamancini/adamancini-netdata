class netdata::config inherits netdata {

  if $netdata::config_manage {
    
    file { 'netdata config file':
      ensure => file,
      path   => $netdata::config_file,
      owner  => $netdata::service_name,
      group  => $netdata::service_name,
      mode   => '0664',
    }

    validate_hash($netdata::options)
    $ini_defaults = {
      'path' => $netdata::config_file,
      'ensure' => 'present',
    }
    create_ini_settings($netdata::options, $ini_defaults)
  }
}
