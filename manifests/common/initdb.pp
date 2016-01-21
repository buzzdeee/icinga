define icinga::common::initdb (
  $dbtype,
  $test_table,
  $schema,
  $dbuser,
  $dbpasswd,
  $dbhost,
  $dbname,
  ){
  $dbclient=$icinga::params::dbclient[$dbtype]
  $conn="${dbclient} --user=${dbuser} --password=${dbpasswd} --host=${dbhost} ${dbname}"
  
  exec{"icinga::initdb_${title}":
    command => "/bin/sh -c '${conn} < ${schema}'",
    unless  => "/bin/sh -c 'echo \"describe ${test_table}\"|${conn} >/dev/null 2>&1'",
  }
}
