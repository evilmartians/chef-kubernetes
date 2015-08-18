#
# Cookbook Name:: kubernetes
# Recipe:: default
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

include_recipe 'runit'
include_recipe 'kubernetes::docker_install'
include_recipe 'network_interfaces'

internal_ip = node['network']['interfaces'][node['kubernetes']['interface']]
              .addresses.find { |addr, properties| properties['family'] == 'inet' }.first

runit_service 'docker_core' do
  default_logger true
  template_name 'docker_core'
end

runit_service 'etcd' do
  default_logger true
  template_name 'docker'
  options(
    docker_args: '--host=unix:///var/run/docker_core.sock',
    run_args: '--name=core-etcd -i --rm --net=host -v /var/lib/etcd/data:/var/lib/etcd/data:rw -v /etc/ssl:/etc/ssl:ro',
    image: "quay.io/coreos/etcd:#{node['kubernetes']['etcd']['version']}",
    command: "--data-dir=/var/lib/etcd/data \
    --name=#{node.fqdn} --initial-advertise-peer-urls=http://#{internal_ip}:2380 \
    --listen-peer-urls=http://#{internal_ip}:2380 \
    --listen-client-urls=http://#{internal_ip}:2379,http://127.0.0.1:2379,http://127.0.0.1:4001 \
    --advertise-client-urls=http://#{internal_ip}:2379 \
    --discovery=#{node['kubernetes']['etcd']['discovery_url']}"
  )
end

bash 'provide_flannel_network' do
  code "docker -H unix:///var/run/docker_core.sock run --net=host --rm -i --entrypoint=/etcdctl quay.io/coreos/etcd:#{node['kubernetes']['etcd']['version']} set /coreos.com/network/config '#{node['kubernetes']['flannel']['network'].to_json}'"
end

runit_service 'flannel' do
  default_logger true
  template_name 'docker'
  options(
    docker_args: '--host=unix:///var/run/docker_core.sock',
    run_args: '--name=core-flanneld -i --rm --net=host --privileged -v /run/flannel:/run/flannel -v /dev/net:/dev/net',
    image: "quay.io/coreos/flannel:#{node['kubernetes']['flannel']['version']}",
    command: "/opt/bin/flanneld --ip-masq=true --iface=#{internal_ip} --etcd-endpoints=http://#{internal_ip}:2379"
  )
end

if File.exist? '/run/flannel/subnet.env'
  flannel_network = Hash[File.read('/run/flannel/subnet.env').lines.map { |l| l.downcase.chomp.split('=') }]

  network_interfaces 'kube0' do
    target IPAddress::IPv4.new(flannel_network['flannel_subnet']).address
    mask IPAddress::IPv4.new(flannel_network['flannel_subnet']).netmask
    bridge ['none']
  end

  runit_service 'docker_more' do
    default_logger true
    template_name 'docker_core'
    options(
      args: "--bridge=kube0 --mtu=#{flannel_network['flannel_mtu']} --pidfile=/var/run/docker.pid --host=unix:///var/run/docker.sock"
    )
  end
end
