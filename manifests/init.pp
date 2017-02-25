class netdata (
  String $release_version,
  Stdlib::Absolutepath $config_dir,
  Stdlib::Absolutepath $config_file,
  Boolean $custom_registry_enabled,
  Optional[String] $custom_registry_hostname,
  Optional[String] $custom_registry_to_announce,
  Boolean $config_manage,
  Boolean $install_dependencies,
  Boolean $install_plugin_dependencies,
  Boolean $install_jq,
  Boolean $install_from_git,
  Optional[String] $install_dir_root,
  String $installation_source,
  Optional[String] $repo_location,
  String $repo_ensure,
  Boolean $service_enable,
  String $service_ensure,
  Boolean $service_manage,
  String $service_name,
  String $service_file,
  Optional[Boolean] $update_with_cron,
  Optional[Integer] $update_cron_hour,
  Optional[Integer] $update_cron_min,
  Optional[Integer] $update_cron_weekday,
  Optional[String] $update_cron_user,
  Optional[String] $service_provider,
  Optional[Hash] $options,
  Optional[Boolean] $alarms_manage,
  Optional[Boolean] $alarms_send_email,
  Optional[String] $alarms_default_email_recipient,
  Optional[Boolean] $alarms_send_pushover,
  Optional[String] $alarms_default_pushover_recipient,
  Optional[String] $alarms_pushover_app_token,
  Optional[Boolean] $alarms_send_telegram,
  Optional[String] $alarms_default_telegram_recipient,
  Optional[String] $alarms_telegram_bot_token,
  Optional[Boolean] $alarms_send_slack,
  Optional[String] $alarms_slack_webhook_url,
  Optional[String] $alarms_default_slack_recipient,
  ) {

  contain netdata::install
  contain netdata::config
  contain netdata::service

  Class['::netdata::install'] ->
  Class['::netdata::config'] ~>
  Class['::netdata::service']
}
