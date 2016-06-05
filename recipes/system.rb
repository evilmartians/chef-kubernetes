#
# Cookbook Name:: kubernetes
# Recipe:: system
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#


bash 'install_nsenter' do
  code <<-EOH
/usr/bin/docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter
chmod +x /usr/local/bin/nsenter
/usr/bin/docker rmi jpetazzo/nsenter
EOH
  not_if { File.exists? '/usr/local/bin/nsenter' }
end

package 'socat'

%w(kubelet kubectl).each do |f|
  remote_file "/usr/local/bin/#{f}" do
    source "https://storage.googleapis.com/kubernetes-release/release/#{node[:kubernetes][:version]}/bin/linux/amd64/#{f}"
    mode '0755'
    not_if { Digest::MD5.file("/usr/local/bin/#{f}").to_s == node[:kubernetes][:md5][f.to_sym] rescue false }
  end
end

service 'kubelet' do
  provider node['platform_version'].to_f < 16.04 ? Chef::Provider::Service::Upstart : Chef::Provider::Service::Systemd
  supports :restart => true
  start_command "/usr/local/bin/kubelet --api_servers=https://#{node[:kubernetes][:master]}:#{node[:kubernetes][:secure_port]} --cluster-dns=#{node[:kubernetes][:cluster_dns]} hostname_override=#{node[:hostname]} --allow_privileged=true --config=/etc/kubernetes/manifests --kubeconfig=/etc/kubernetes/kubeconfig.yaml"
  action [:enable, :start]
end
