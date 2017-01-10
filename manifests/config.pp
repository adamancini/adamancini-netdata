class netdata::config inherits netdata {

  if $netdata::config_manage {

    notify { 'update netdata configuration': }

    file { $netdata::config_dir:
      ensure => directory,
      owner  => $netdata::service_name,
      group  => $netdata::service_name,
      mode   => '0755',
    }

    file { $netdata::config_file:
      ensure  => present,
      owner   => $netdata::service_name,
      group   => $netdata::service_name,
      mode    => '0664',
      require => File[$netdata::config_dir],
    }

    validate_hash($netdata::config::options)
    $ini_defaults = { 'path' => $netdata::config_file }
    create_ini_settings($netdata::config::options, $ini_defaults)
  }
}
