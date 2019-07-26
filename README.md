# puppet-minio

[![Build Status][build-shield]][build-status]
[![Puppet Forge][forge-shield]][forge-minio]
[![Puppet Forge - downloads][forge-shield-dl]][forge-minio]
[![Puppet Forge - scores][forge-shield-sc]][forge-minio]

## Description

A Puppet module for managing [Minio][minio] (Amazon S3 compatible storage)
settings.

This module allows you to install and configure Minio using pre-built binaries
and does not need external package repositories. You can chose to install Minio
with default settings, or customize all settings to your liking.

## Setup

### What Minio affects

- `puppet-minio` depends on
  - [puppetlabs-stdlib][puppetlabs-stdlib],
  - [lwf-remote_file][lwf-remote_file],
- it manages a user and group `minio`
- it manages the Minio directory (`/opt/minio`) and the storage (`/var/minio`)
- it install a `minio` service listening on port `3000`

### Beginning with Minio

The simplest use case is to rely on defaults. This can be done by simply
including the class:

```puppet
include ::minio
```

## Reference

Management of user, group and home is set to false (default).  
The configuration is managed by enviroment variables. Those are written into `/etc/minio/minio.env` and included into the service file.  
The available enviroment variables are:  
```
accessKey
secretKey
region
browser
worm
domain
public_ips
etcd_endpoints
sse_vault_endpoint
sse_vault_approle_id
sse_vault_approle_secret
sse_vault_key_name
```

Here is an example yaml configuration:  

```
---
version: 'RELEASE.2019-03-20T22-38-47Z'
checksum: '40f7ad9396fa377a6573859786e54c732b1080e4d93aee54e617c7441e449d2e'
package_ensure: 'present'
base_url: 'http://file-server.company/archive/minio'
manage_user: true
manage_group: true
manage_home: true
listen_ip: '127.0.0.1'
listen_port: 9000
storage_root: '/opt/minio-storage'
env_variables:
  accessKey: 'minio'
  secretKey: 'password'
  region: 'minio'
  browser: 'on'
```



### Class: `minio`

```puppet
class { 'minio':
    package_ensure => 'present',
    manage_user => true,
    manage_group => true,
    manage_home => true,
    owner => 'minio',
    group => 'minio',
    home => '/home/minio',
    version => 'RELEASE.2017-05-05T01-14-51Z',
    checksum => '59cd3fb52292712bd374a215613d6588122d93ab19d812b8393786172b51d556',
    checksum_type => 'sha256',
    installation_directory => '/opt/minio',
    storage_root => '/opt/minio-storage',
    listen_ip => '127.0.0.1',
    listen_port => '9000',
    environment_file => '/etc/minio/minio.env'
    environement_file_template => 'minio/minio.env.erb'
    env_variables => {
      accessKey => 'minio',
      secretKey => 'password',
      region => 'minio',
      browser => 'on',
      worm => 'off',
      domain => '',
      public_ips => '',
      etcd_endpoints => '',
      sse_vault_endpoint => '',
      sse_vault_approle_id => '',
      sse_vault_approle_secret => '',
      sse_vault_key_name => ''
    }   
    manage_service => true,
    service_template => 'minio/systemd.erb',
    service_path => '/lib/systemd/system/minio.service',
    service_provider => 'systemd',
    service_mode => '0644',
}
```

### Class: `minio::user`

```puppet
class { 'minio::user':
    manage_user => false,
    manage_group => false,
    manage_home => false,
    owner => 'minio',
    group => 'minio',
    home => '/home/minio',
}
```

### Class: `minio::install`

```puppet
class { 'minio::install':
    package_ensure => 'present',
    owner => 'minio',
    group => 'minio',
    version => 'RELEASE.2017-05-05T01-14-51Z',
    checksum => '59cd3fb52292712bd374a215613d6588122d93ab19d812b8393786172b51d556',
    checksum_type => 'sha256',
    installation_directory => '/opt/minio',
    storage_root => '/opt/minio-storage',
    listen_ip => '127.0.0.1',
    listen_port => '9000',
    environement_file => '/etc/minio/minio.env'
    manage_service => true,
    service_template => 'minio/systemd.erb',
    service_path => '/lib/systemd/system/minio.service',
    service_provider => 'systemd',
    service_mode => '0644',
}
```

### Class: `minio::service`

```puppet
class { 'minio::service':
    manage_service => true,
    service_provider => 'systemd',
}
```

### Class: `minio::config`

```puppet
class { 'minio::config':
    owner => 'minio',
    group => 'minio',
    installation_directory => '/opt/minio',
    storage_root => '/var/minio',
    env_variables => {
      accessKey => 'minio',
      secretKey => 'password',
      region => 'minio',
      browser => 'on',
      worm => 'off',
      domain => '',
      public_ips => '',
      etcd_endpoints => '',
      sse_vault_endpoint => '',
      sse_vault_approle_id => '',
      sse_vault_approle_secret => '',
      sse_vault_key_name => ''
    }
}
```

## Limitations

See [metadata.json](metadata.json) for supported platforms.

## Development

### Running tests

This project contains tests for [rspec-puppet][puppet-rspec].

Quickstart:

```console
gem install bundler
bundle install
bundle exec rake test
```

When submitting pull requests, please make sure that module documentation,
test cases and syntax checks pass.

[minio]: https://minio.io
[puppetlabs-stdlib]: https://github.com/puppetlabs/puppetlabs-stdlib
[lwf-remote_file]: https://github.com/lwf/puppet-remote_file
[puppet-rspec]: http://rspec-puppet.com/

[build-status]: https://travis-ci.org/kogitoapp/puppet-minio
[build-shield]: https://travis-ci.org/kogitoapp/puppet-minio.png?branch=master
[forge-minio]: https://forge.puppetlabs.com/kogitoapp/minio
[forge-shield]: https://img.shields.io/puppetforge/v/kogitoapp/minio.svg
[forge-shield-dl]: https://img.shields.io/puppetforge/dt/kogitoapp/minio.svg
[forge-shield-sc]: https://img.shields.io/puppetforge/f/kogitoapp/minio.svg
