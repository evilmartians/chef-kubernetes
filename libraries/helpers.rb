module Kubernetes
  # Few helpers for Kubernetes installation.
  module Helpers
    def k8s_ip(n = node)
      n['network']['interfaces'][n['kubernetes']['interface']]['addresses']
        .find { |_addr, data| data['family'] == 'inet' }.first
    rescue
      '127.0.0.1'
    end

    def k8s_hostname(n = node)
      n['kubernetes']['register_as'] == 'ip' ? k8s_ip(n) : n['hostname']
    end

    def install_via(n = node)
      result = n['kubernetes']['install_via']
      unless n['kubernetes']['install_via'] == 'static_pods'
        result = 'upstart' if n['init_package'] == 'init' and n['packages'].key?('upstart')
        result = 'systemd' if n['init_package'] == 'systemd'
      end
      result
    end

    def kubelet_args
      options = Hash[node['kubernetes']['kubelet'].map { |k, v| [k.gsub(/_/, '-'), v] } ]
      options.store("address", k8s_ip(node)) # FIXME
      options.store("hostname-override", k8s_hostname(node)) #  FIXME
      options.store("node-ip", k8s_ip(node)) # FIXME
      options.sort_by{ |k,v| k}.map{|k,v| v.nil? ? "--#{k}" : "--#{k}=#{v}"}
    end
  end
end

Chef::Recipe.send(:include, ::Kubernetes::Helpers)
Chef::Resource.send(:include, ::Kubernetes::Helpers)
