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

  case $dbtype {
    'mysql': {
      $conn="${dbclient} --user=${dbuser} --password=${dbpasswd} --host=${dbhost} ${dbname}"

      exec{"icinga::initdb_${title}":
        command => "/bin/sh -c '${conn} < ${schema}'",
        unless  => "/bin/sh -c 'echo \"describe ${test_table}\"|${conn} >/dev/null 2>&1'",
      }
    }
    'pgsql': {
      postgresql_psql { "icinga_initdb_${title}":
        command     => "\\i ${schema}",
        db          => $dbname,
        port        => '5432',
        psql_user   => $dbuser,
        psql_path   => $dbclient,
        connect_settings => {
          PGPASSWORD => $dbpasswd,
          PGHOST     => $dbhost,
        },
        unless      => "SELECT dbversion_id FROM ${test_table}",
      }
    }
    default: {
      fail("${::module_name} doesn't support dbtype: ${dbtype}")
    }
  }  
}
