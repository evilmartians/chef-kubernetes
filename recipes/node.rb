#
# Cookbook Name:: kubernetes
# Recipe:: node
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

include_recipe 'kubernetes::default'

internal_ip = node[:network][:interfaces][node['kubernetes']['interface']]
              .addresses.find {|addr, properties| properties['family'] == 'inet'}.first

if Chef::Config[:solo]
  master_ip = node['kubernetes']['master']['ip']
else
  master_node = search(:node, 'role:kube_master').first
  master_ip = master_node[:network][:interfaces][node['kubernetes']['interface']]
              .addresses.find {|addr, properties| properties['family'] == 'inet'}.first
end

runit_service 'kubelet' do
  default_logger true
  template_name 'docker'
  options(
    run_args: '--name=kubelet -i --rm --net=host -v /var/run/docker.sock:/var/run/docker.sock --privileged',
    image: "gcr.io/google_containers/hyperkube:#{node['kubernetes']['version']}",
    command: "/hyperkube kubelet --api_servers=http://#{master_ip}:8080 --v=2 --address=#{internal_ip} --enable_server --hostname_override=#{internal_ip} --allow-privileged"
  )
end

runit_service 'kube_proxy' do
  default_logger true
  template_name 'docker'
  options(
    run_args: '--name=kubernetes-proxy -i --rm --net=host --privileged -v /var/run/docker.sock:/var/run/docker.sock',
    image: "gcr.io/google_containers/hyperkube:#{node['kubernetes']['version']}",
    command: "/hyperkube proxy --master=http://#{master_ip}:8080 --v=2"
  )
end
