#
# Cookbook Name:: kubernetes
# Recipe:: kubeconfig
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

require 'base64'

ca_file = Chef::EncryptedDataBagItem.load(node['kubernetes']['databag'], 'ca_ssl')['public_key']

file node['kubernetes']['client_ca_file'] do
  content ca_file
end

template '/etc/kubernetes/kubeconfig.yaml' do
  source 'kubeconfig.yaml.erb'
  if node['kubernetes']['token_auth']
    variables(token: Chef::EncryptedDataBagItem.load(node['kubernetes']['databag'], 'users')['users']
                .find { |user| user['name'] == 'kubelet' }['token'],
              ca_file: Base64.encode64(ca_file).delete("\n"),
              user: 'kubelet')
  end
end
