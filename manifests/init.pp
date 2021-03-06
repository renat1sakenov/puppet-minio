# Class: minio
# ===========================
#
# Manages a Minio installation on various Linux/BSD operating systems.
#
# Parameters
# ----------
#
# * `package_ensure`
# Decides if the `minio` binary will be installed. Default: 'present'
#
# * `owner`
# The user owning minio and its' files. Default: 'minio'
#
# * `group`
# The group owning minio and its' files. Default: 'minio'
#
# * `home`
# Qualified path to the users' home directory. Default: empty
#
# * `environment_file`
# Path to the .env file for the service
#
# * `environment_file_template`
# Path to the template for the .env file
#
# * `base_url`
# Download base URL. Default: Github. Can be used for local mirrors.
#
# * `version`
# Release version to be installed.
#
# * `checksum`
# Checksum for the binary.
#
# * `checksum_type`
# Type of checksum used to verify the binary being installed. Default: 'sha256'
#
# * `installation_directory`
# Target directory to hold the minio installation. Default: '/opt/minio'
#
# * `storage_root`
# Directory where minio will keep all data. Default: '/var/minio'
#
# * `listen_ip`
# IP address on which Minio should listen to requests.
#
# * `listen_port`
# Port on which Minio should listen to requests.
#
# * `env_variables`
# Hash style settings for configuring Minio through environement variables
#
#
# * `manage_service`
# Should we manage a service definition for Minio?
#
# * `service_template`
# Path to service template file.
#
# * `service_path`
# Where to create the service definition.
#
# * `service_provider`
# Which service provider do we use?
#
# * `service_mode`
# File mode for the created service definition.
#
# Examples
# --------
#
# @example
#    class { 'minio':
#    }
#
# Authors
# -------
#
# Daniel S. Reichenbach <daniel@kogitoapp.com>
#
# Copyright
# ---------
#
# Copyright 2017 Daniel S. Reichenbach <https://kogitoapp.com>
#
class minio (
  Enum['present','absent'] $package_ensure  = $::minio::params::package_ensure,
  String $owner                             = $::minio::params::owner,
  String $group                             = $::minio::params::group,
  Optional[String] $home                    = $::minio::params::home,
  String $environment_file                  = $::minio::params::environment_file,
  String $environment_file_template         = $::minio::params::environment_file_template,
  String $configuration_directory           = $::minio::params::configuration_directory,
  Boolean $manage_service                   = $::minio::params::manage_service, 
  String $service_template                  = $::minio::params::service_template,
  String $service_path                      = $::minio::params::service_path,
  String $service_provider                  = $::minio::params::service_provider,
  String $service_mode                      = $::minio::params::service_mode,
  String $storage_root                      = $::minio::params::storage_root,
  String $base_url                          = $::minio::params::base_url,
  String $version                           = $::minio::params::version,
  String $checksum                          = $::minio::params::checksum,
  String $checksum_type                     = $::minio::params::checksum_type,
  String $installation_directory            = $::minio::params::installation_directory,
  String $listen_ip                         = $::minio::params::listen_ip,
  Integer $listen_port                      = $::minio::params::listen_port,
  Hash $env_variables                       = $::minio::params::env_variables

  ) inherits minio::params {

  class { '::minio::install': }

  class { '::minio::config': }
  class { '::minio::service': }

  anchor { 'minio::begin': }
  anchor { 'minio::end': }

  Anchor['minio::begin']
  -> Class['minio::install']
  -> Class['minio::config']
  ~> Class['minio::service']
}
