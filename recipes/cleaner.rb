#
# Cookbook Name:: kubernetes
# Recipe:: cleaner
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

require 'fileutils'

%w(apiserver controller-manager scheduler proxy addon-manager).each do |srv|

  if node['kubernetes']['install_via'] == 'systemd'
    FileUtils.rm_f "/etc/kubernetes/manifests/#{srv}.yaml"
  end

  if node['kubernetes']['install_via'] == 'static_pods'
    systemd_service "kube-#{srv}" do
      action [:disable, :stop]
      only_if { node['init_package'] == 'systemd' }
    end
  end

  if node['kubernetes']['install_via'] == 'upstart'
    FileUtils.rm_f "/etc/kubernetes/manifests/#{srv}.yaml"
    systemd_service "kube-#{srv}" do
      action [:disable, :stop]
      only_if { node['init_package'] == 'systemd' }
    end
  end

end

# Cleanup old kubernetes binaries
versions = Dir["/opt/kubernetes/*"].sort_by {|f| File.mtime(f)}
FileUtils.rm_rf(versions[0...-node['kubernetes']['keep_versions']])

# Cleanup old skydns manifests
%w(kubedns-cm kubedns-sa skydns-deployment skydns-svc).each do |manifest|
  file "/etc/kubernetes/addons/#{manifest}.yaml" do
    action :delete
  end
end

# Cleanup DNS RBAC manifest when using kubedns
if node['kubernetes']['addons']['dns']['controller'] == 'kubedns'
  %w(clusterrole clusterrolebinding).each do |manifest|
    file "/etc/kubernetes/addons/dns-#{manifest}.yaml" do
      action :delete
    end
  end
end
