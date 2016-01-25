define icinga::common::initdb (
  $dbtype,
  $test_table,
  $schema,
  $dbuser,
  $dbpasswd,
  $dbhost,
  $dbname,
  ){
  case $dbtype in {
    'mysql': {
      $dbclient=$icinga::params::dbclient[$dbtype]
      $conn="${dbclient} --user=${dbuser} --password=${dbpasswd} --host=${dbhost} ${dbname}"

      exec{"icinga::initdb_${title}":
        command => "/bin/sh -c '${conn} < ${schema}'",
        unless  => "/bin/sh -c 'echo \"describe ${test_table}\"|${conn} >/dev/null 2>&1'",
      }
    }
    'pgsql': {
      postgresql_psql { 'icinga_initdb_${title}':
        command     => "\i ${schema}",
        db          => $dbname,
        psql_user   => $dbuser,
        environment => "PGPASSWORD=${dbpasswd}",
        unless      => "\dt ${test_table}",
      }
    }
    default: {
      fail("${::module_name} doesn't support dbtype: ${dbtype}")
    }
  
}
