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
      $dbclient                 = {
        'mysql' => '/usr/bin/mysql',
        'pgsql' => '/usr/bin/pgsql'}
    }
    'CentOS': {
      $with_repo         = true
      $icinga_bin        = '/usr/sbin/icinga2'
      $icinga_share_path = '/usr/share'
      $dbclient                 = {
        'mysql' => '/usr/bin/mysql',
        'pgsql' => '/usr/bin/pgsql'}
    }
    'ScientificLinux': {
      $with_repo         = true
      $icinga_bin        = '/usr/sbin/icinga2'
      $icinga_share_path = '/usr/share'
      $dbclient                 = {
        'mysql' => '/usr/bin/mysql',
        'pgsql' => '/usr/bin/pgsql'}
    }
    'Ubuntu': {
      $with_repo         = true
      $icinga_bin        = '/usr/sbin/icinga2'
      $icinga_share_path = '/usr/share'
      $dbclient                 = {
        'mysql' => '/usr/bin/mysql',
        'pgsql' => '/usr/bin/pgsql'}
    }
    'OpenBSD': {
      $with_repo         = false
      $icinga_bin        = '/usr/local/sbin/icinga2'
      $icinga_share_path = '/usr/local/share'
      $dbclient                 = {
        'mysql' => '/usr/local/bin/mysql',
        'pgsql' => '/usr/local/bin/psql'}
    }
    default: {
      fail("${::module_name} does not support operatingsystem: ${::operatingsystem}")
    }
  }
}
