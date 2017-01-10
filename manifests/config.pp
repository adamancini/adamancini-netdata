class netdata::config inherits netdata {

  $config_directory = $netdata::config_dir

  if $netdata::config_manage {

    notify { 'update netdata configuration': }

    file { $config_directory:
      ensure => directory,
      owner  => $netdata::service_name,
      group  => $netdata::service_name,
      mode   => '0755',
    }

    file { "${config_directory}/netdata.conf":
      ensure  => present,
      owner   => $netdata::service_name,
      group   => $netdata::service_name,
      mode    => '0664',
      require => File[$config_directory],
    }

    validate_hash($netdata::config::options)
    $ini_defaults = { 'path' => "${netdata::config_dir}/netdata.conf" }
    create_ini_settings($netdata::config::options, $ini_defaults)
  }
}
