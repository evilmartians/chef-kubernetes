name             'kubernetes'
maintainer       'Maxim Filatov'
maintainer_email 'bregor@evilmartians.com'
license          'MIT'
description      'Installs/Configures google kubernetes'
long_description 'Google Kubernetes installer for Ubuntu'
version          '1.20.4'

chef_version     '>= 12.14'

supports         'ubuntu', '>= 16.04'

depends          'apt'
depends          'etcd', '~> 6.0'
depends          'network_interfaces_v2'
depends          'tar'
depends          'firewall'
depends          'ufw'

source_url       'https://github.com/evilmartians/chef-kubernetes'
issues_url       'https://github.com/evilmartians/chef-kubernetes/issues'
