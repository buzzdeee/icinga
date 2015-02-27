define icinga::feature(
  $action
) {

  if ! ($action in ['enable', 'disable']) {
    fail('action must be "enable" or "disable"')
  }

  $command="${icinga::params::icinga_bin} feature ${action} ${title}"
  $featurecheck="/bin/ls ${icinga::params::features_enabled_path}/${title}.conf"
  
  case $action {
    'enable':  {
      exec {"${action}-${title}":
        command => $command,
        unless  => $featurecheck,
      }
    }
    'disable': {
      exec {"${action}-${title}":
        command => $command,
        onlyif  => $featurecheck,
      }
    }
  }
  
}
