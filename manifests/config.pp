class netdata::config inherits netdata {

  if $netdata::config_manage == true {

    notify { "update netdata configuration": }

    file { $netdata::config_dir:
      ensure => directory,
      owner  => $netdata::service_name,
      group  => $netdata::service_name,
      mode   => '0755',
      before => $netdata::config_file,
    }

    file { "${netdata::config_dir}/netdata.conf":
      ensure => present,
      owner  => $netdata::service_name,
      group  => $netdata::service_name,
      mode   => '0664',
    }

    validate_hash($netdata::config::options)
    $ini_defaults = { 'path' => "${netdata::config_dir}/netdata.conf" }
    create_ini_settings($netdata::config::options, $ini_defaults)
  }
}
