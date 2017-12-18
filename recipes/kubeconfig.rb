#
# Cookbook Name:: kubernetes
# Recipe:: kubeconfig
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

require 'base64'

ca_file = data_bag_item(node['kubernetes']['databag'], 'ca_ssl')['public_key']

file node['kubernetes']['client_ca_file'] do
  content ca_file
end

template '/etc/kubernetes/system:kube-proxy_config.yaml' do
  source 'kubeconfig.yaml.erb'
  if node['kubernetes']['token_auth']
    users_data = data_bag_item(node['kubernetes']['databag'], 'users')['users']
    token = users_data.find { |user| user['name'] == 'system:kube-proxy' }['token']

    variables(
      token: token,
      ca_file: Base64.encode64(ca_file).delete("\n"),
      user: 'system:kube-proxy'
    )
  end
end
