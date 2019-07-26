# Class: minio::params
# ===========================
# Default values 
#
class minio::params {

  $package_ensure                    = 'present' 
  $owner                             = 'minio'
  $group                             = 'minio'
  $home                              = '/home/minio'
  $listen_ip                         = '127.0.0.1'
  $listen_port                       = 9000
  $configuration_directory           = '/etc/minio'
  $environment_file                  = "${configuration_directory}/minio.env"
  $environment_file_template         = 'minio/minio.env.erb'
  $service_template                  = 'minio/systemd.erb'
  $service_path                      = '/lib/systemd/system/minio.service'
  $service_provider                  = 'systemd'
  $service_mode                      = '0644'
  $manage_service                    =  true
  $storage_root                      = '/opt/minio-storage'
  $installation_directory            = '/opt/minio'
  $checksum_type                     = 'sha256'
  $checksum                          = undef
  $version                           = undef
  $base_url                          = undef

  $env_variables = {
      accessKey                 => 'minio',
      secretKey                 => 'password',
      region                    => 'minio',
      browser                   => 'on',
      worm                      => 'off',
      domain                    => '',
      public_ips                => '',
      etcd_endpoints            => '',
      sse_vault_endpoint        => '',
      sse_vault_approle_id      => '',
      sse_vault_approle_secret  => '',
      sse_vault_key_name        => ''
      
  }
}
