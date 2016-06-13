#
# Cookbook Name:: kubernetes
# Recipe:: system
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

internal_ip = node[:network][:interfaces][node['kubernetes']['interface']]
              .addresses.find {|addr, properties| properties['family'] == 'inet'}.first

hostname = internal_ip


poise_service 'kubelet' do
  provider node['platform_version'].to_f < 16.04 ? :runit : :systemd
  command "/usr/local/bin/kubelet --api_servers=https://#{node[:kubernetes][:master]}:#{node[:kubernetes][:api][:secure_port]} --cluster-dns=#{node[:kubernetes][:cluster_dns]} --hostname_override=#{hostname} --allow_privileged=true --config=/etc/kubernetes/manifests --kubeconfig=/etc/kubernetes/kubeconfig.yaml --log-dir=/var/log/kubernetes"
end
