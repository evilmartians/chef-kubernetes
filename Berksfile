source 'https://supermarket.chef.io'

cookbook 'apt'
cookbook 'tar'
cookbook 'etcd', '~> 5.5'
cookbook 'firewall'
cookbook 'ufw'
cookbook 'network_interfaces_v2', github: 'target/network_interfaces_v2-cookbook'

metadata

group :integration do
  cookbook 'testrig', path: './test/integration/cookbooks/testrig', group: :integration
end
