class minio::config (
  String $owner                   = $minio::owner,
  String $group                   = $minio::group,
  String $environment_file        = $minio::environment_file,
  Hash   $env_variables           = $minio::env_variables
  ) {

      $default_configuration = @("EOT")
         MINIO_ACCESS_KEY=${env_variables[accessKey]}
         MINIO_SECRET_KEY=${env_variables[secretKey]}
         MINIO_REGION=${env_variables[region]}
         MINIO_BROWSER=${env_variables[browser]}
         MINIO_WORM=${env_variables[worm]}
         MINIO_DOMAIN=${env_variables[domain]}
         MINIO_PUBLIC_IPS=${env_variables[public_ips]}
         MINIO_ETCD_ENDPOINTS=${env_variables[etcd_endpoints]}
         MINIO_SSE_VAULT_ENDPOINT=${env_variables[sse_vault_endpoint]}
         MINIO_SSE_VAULT_APPROLE_ID=${env_variables[sse_vault_approle_id]}
         MINIO_SSE_VAULT_APPROLE_SECRET=${env_variables[sse_vault_approle_secret]}
         MINIO_SSE_VAULT_KEY_NAME=${env_variables[sse_vault_key_name]}
         | EOT

      file {"${environment_file}":
        content => $default_configuration,
        #content => template('minio/minio.env.erb'),
        owner   => $owner,
        group   => $group,
        mode    => '0600',
      }
}
