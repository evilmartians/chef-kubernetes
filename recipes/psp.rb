#
# Cookbook Name:: kubernetes
# Recipe:: psp
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

%w(default).each do |name|
  template "/etc/kubernetes/addons/#{name}-psp.yaml" do
    source "#{name}-psp.yaml.erb"
  end
  %w(clusterrole clusterrolebinding).each do |kind|
    template "/etc/kubernetes/addons/#{name}-psp-#{kind}.yaml" do
      source "#{name}-psp-#{kind}.yaml.erb"
    end
  end
end
