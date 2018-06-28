name             'kubernetes'
maintainer       'Maxim Filatov'
maintainer_email 'bregor@evilmartians.com'
license          'MIT'
description      'Installs/Configures google kubernetes'
long_description 'Google Kubernetes installer for deb-based distros with docker'
version          '1.9.7'

chef_version '>= 12.14', '< 14'

supports 'ubuntu', '>= 14.04'

depends 'apt'
depends 'etcd', '~> 4.1'
depends 'network_interfaces_v2'
depends 'tar'
depends 'firewall'
depends 'ufw'

source_url 'https://github.com/evilmartians/chef-kubernetes'
issues_url 'https://github.com/evilmartians/chef-kubernetes/issues'
