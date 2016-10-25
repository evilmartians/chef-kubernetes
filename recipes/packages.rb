#
# Cookbook Name:: kubernetes
# Recipe:: packages
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

apt_repository 'docker' do
  uri 'https://apt.dockerproject.org/repo'
  distribution "#{node['platform']}-#{node['lsb']['codename']}"
  components ['main']
  keyserver 'hkp://p80.pool.sks-keyservers.net:80'
  key '58118E89F3A912897C070ADBF76221572C52609D'
end

directory '/etc/docker'

file '/etc/docker/daemon.json' do
  owner 'root'
  group 'root'
  mode '0644'
  content({ 'storage-driver' => 'overlay2' }.to_json)
  not_if { node['platform_version'].to_f < 16.04 }
end

package 'docker-engine' do
  options '-o Dpkg::Options::="--force-confold"'
end

package 'iptables'
package 'ebtables'
package 'socat'
package 'ethtool'
package 'kmod'
package 'tcpd'
package 'dbus'
package 'apt-transport-https'

if node['lsb']['release'].to_i >= 16
  apt_repository 'kubernetes' do
    uri 'http://apt.kubernetes.io/'
    distribution "kubernetes-#{node['lsb']['codename']}"
    components ['main']
    key 'https://packages.cloud.google.com/apt/doc/apt-key.gpg'
  end
  package 'kubernetes-cni'
end

bash 'install_nsenter' do
  code <<-EOH
/usr/bin/docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter
chmod +x /usr/local/bin/nsenter
/usr/bin/docker rmi jpetazzo/nsenter
EOH
  not_if { File.exist? '/usr/local/bin/nsenter' }
end

directory "/opt/kubernetes/#{node[:kubernetes][:version]}/bin" do
  recursive true
end

%w(kubelet kubectl).each do |f|
  remote_file "/opt/kubernetes/#{node[:kubernetes][:version]}/bin/#{f}" do
    source "https://storage.googleapis.com/kubernetes-release/release/#{node[:kubernetes][:version]}/bin/linux/amd64/#{f}"
    mode '0755'
    not_if do
      begin
        Digest::MD5.file("/opt/kubernetes/#{node[:kubernetes][:version]}/bin/#{f}").to_s == node[:kubernetes][:md5][f.to_sym]
      rescue
        false
      end
    end
  end
end

link '/usr/local/bin/kubectl' do
  to "/opt/kubernetes/#{node[:kubernetes][:version]}/bin/kubectl"
end
