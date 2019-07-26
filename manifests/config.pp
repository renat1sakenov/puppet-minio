# Class: Config
# ===========================
#
# Writes the configuration as a environment file
#
class minio::config (
  String $owner                     = $minio::owner,
  String $group                     = $minio::group,
  String $environment_file          = $minio::environment_file,
  String $environment_file_template = $minio::environment_file_template,
  Hash   $env_variables             = $minio::env_variables
  ) {

      file {"${environment_file}":
        content => template($environment_file_template),
        owner   => $owner,
        group   => $group,
        mode    => '0600',
      }
}
