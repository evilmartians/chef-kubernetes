#
# Cookbook Name:: kubernetes
# Recipe:: master
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

include_recipe 'kubernetes::default'

internal_ip = node[:network][:interfaces][node['kubernetes']['interface']]
              .addresses.find {|addr, properties| properties['family'] == 'inet'}.first

runit_service 'kube_apiserver' do
  default_logger true
  template_name 'docker'
  options(
    run_args: '-i --rm --net=host -v /var/run/docker.sock:/var/run/docker.sock',
    image: "gcr.io/google_containers/hyperkube:#{node['kubernetes']['version']}",
    command: "/hyperkube apiserver --portal-net=#{node['kubernetes']['flannel']['network']['Network']} --address=#{internal_ip} --etcd_servers=http://127.0.0.1:2379 --cluster_name=kubernetes --v=2"
  )
end

runit_service 'kube_controller_manager' do
  default_logger true
  template_name 'docker'
  options(
    run_args: '-i --rm --net=host -v /var/run/docker.sock:/var/run/docker.sock',
    image: "gcr.io/google_containers/hyperkube:#{node['kubernetes']['version']}",
    command: "/hyperkube controller-manager --master=#{internal_ip}:8080 --v=2"
  )
end

runit_service 'kube_scheduler' do
  default_logger true
  template_name 'docker'
  options(
    run_args: '-i --rm --net=host -v /var/run/docker.sock:/var/run/docker.sock',
    image: "gcr.io/google_containers/hyperkube:#{node['kubernetes']['version']}",
    command: "/hyperkube scheduler --master=#{internal_ip}:8080 --v=2"
  )
end

runit_service 'kubelet' do
  default_logger true
  template_name 'docker'
  options(
    run_args: '-i --rm --net=host -v /var/run/docker.sock:/var/run/docker.sock --privileged',
    image: "gcr.io/google_containers/hyperkube:#{node['kubernetes']['version']}",
    command: "/hyperkube kubelet --api_servers=http://#{internal_ip}:8080 --v=2 --address=#{internal_ip} --enable_server --hostname_override=#{internal_ip} --allow-privileged"
  )
end

runit_service 'kube_proxy' do
  default_logger true
  template_name 'docker'
  options(
    run_args: '-i --rm --net=host --privileged -v /var/run/docker.sock:/var/run/docker.sock',
    image: "gcr.io/google_containers/hyperkube:#{node['kubernetes']['version']}",
    command: "/hyperkube proxy --master=http://#{internal_ip}:8080 --v=2"
  )
end
