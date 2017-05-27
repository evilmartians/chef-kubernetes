module Kubernetes
  # Few helpers for Kubernetes installation.
  module Helpers
    def internal_ip(n = node)
      n['network']['interfaces'][n['kubernetes']['interface']]['addresses']
        .find { |addr, properties| properties['family'] == 'inet' }.first
    rescue
      ''
    end

    def hostname(n = node)
      n['kubernetes']['register_as'] == 'ip' ? internal_ip(n) : n['hostname']
    end

    def install_via(n = node)
      result = n['kubernetes']['install_via']
      unless n['kubernetes']['install_via'] == 'static_pods'
        result = 'upstart' if n['init_package'] == 'init' and n['packages'].has_key?('upstart')
        result = 'systemd' if n['init_package'] == 'systemd'
      end
      result
    end

  end
end

Chef::Recipe.send(:include, ::Kubernetes::Helpers)
