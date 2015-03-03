# == Class: puppet-icinga
#
# Full description of class puppet-icinga here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { puppet-icinga:
#    dbtype => 'pgsql',
#    enabled_features => ['syslog']
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 talamoig
#
class icinga(
  $dbtype            = $icinga::params::dbtype,
  $dbhost            = $icinga::params::dbhost,
  $dbuser            = $icinga::params::dbuser,
  $dbpasswd          = $icinga::params::dbpasswd,
  $dbname            = $icinga::params::dbname,
  $enabled_features  = $icinga::params::features,
  $disabled_features = $icinga::params::no_features,
  $with_repo         = $icinga::params::with_repo
) inherits icinga::params {

  case $::osfamily {
    RedHat: {

      Class[icinga::yumrepo]   -> Class[icinga::package]
      Class[icinga::package]   -> Class[icinga::configure]
      Class[icinga::configure] -> Class[icinga::service]
      
      class { 'icinga::yumrepo': }
      class { 'icinga::package': }
      class { 'icinga::service': }
      class { 'icinga::configure': }
      
    }
    default: { fail("Currently unavailable for ${::osfamily}") }
  }

}
