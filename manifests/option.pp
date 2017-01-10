define netdata::option (
$section = undef,
$setting = undef,
$value   = undef,
$ensure = present,
$path = "${netdata::config_dir}/${netdata::config_file}"
) {
  if $name !~ /^[a-zA-Z0-9\._-]+$/ {
    fail("netdata::option[${name}]: title must be alphanumeric")
  }

  @ini_setting { "sample setting":
    ensure  => present,
    path    => $path,
    section => $section,
    setting => $setting,
    value   => $value,
    tag     => netdata
  }
}