class icinga::params {
  $dbtype                   = 'mysql'
  $dbhost                   = 'localhost'
  $dbuser                   = 'icinga'
  $dbpasswd                 = 'icinga'
  $dbname                   = 'icinga'
  $features                 = []
  $no_features              = []
  $icinga_name              = 'icinga2'
  $features_avail_path      = '/etc/icinga2/features-available'
  $features_enabled_path    = '/etc/icinga2/features-enabled'
  $initdb                   = false
  $dbclient                 = {
    'mysql' => '/usr/bin/mysql',
    'pgsql' => '/usr/bin/pgsql'}
  $dbpasswd_opt             = {
    'mysql' => '-p',
    'pgsql' => '--password'}
  $with_backend             = true
  $with_classicui           = false
  $with_webgui              = false

  case $::operatingsystem {
    'RedHat': {
      $with_repo         = true
      $icinga_bin        = '/usr/sbin/icinga2'
      $icinga_share_path = '/usr/share'
    }
    'CentOS': {
      $with_repo         = true
      $icinga_bin        = '/usr/sbin/icinga2'
      $icinga_share_path = '/usr/share'
    }
    'ScientificLinux': {
      $with_repo         = true
      $icinga_bin        = '/usr/sbin/icinga2'
      $icinga_share_path = '/usr/share'
    }
    'Ubuntu': {
      $with_repo         = true
      $icinga_bin        = '/usr/sbin/icinga2'
      $icinga_share_path = '/usr/share'
    }
    'OpenBSD': {
      $with_repo         = false
      $icinga_bin        = '/usr/local/sbin/icinga2'
      $icinga_share_path = '/usr/local/share'
    }
    default: {
      fail("${::module_name} does not support operatingsystem: ${::operatingsystem}")
    }
  }
}
