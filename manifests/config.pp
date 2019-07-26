class minio::config (
  String $owner                   = $minio::owner,
  String $group                   = $minio::group,
  String $environment_file        = $minio::environment_file,
  Hash   $env_variables           = $minio::env_variables
  ) {

      file {"${environment_file}":
        content => template('minio/minio.env.erb'),
        owner   => $owner,
        group   => $group,
        mode    => '0600',
      }
}
