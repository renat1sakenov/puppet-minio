class minio::config (
  String $owner                   = $minio::owner,
  String $group                   = $minio::group,
  String $environment_file        = $minio::environment_file,
  String $accessKey               = $minio::accessKey,
  String $secretKey               = $minio::secretKey,
  String $region                  = $minio::region,
  String $browser                 = $minio::browser,
  String $http_logger             = $minio::http_logger,
  ) {

      $default_configuration = "MINIO_ACCESS_KEY=${accessKey},
         MINIO_SECRET_KEY=${secretKey},
         MINIO_REGION=${region},
         MINIO_BROWSER=${browser},
         MINIO_LOGGER_HTTP_ENDPOINT=${http_logger}\r\n"

      file { "${environment_file}":
        content => $default_configuration,
        owner   => $owner,
        group   => $group,
        mode    => '0600',
      }
}
