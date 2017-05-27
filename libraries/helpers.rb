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

  end
end

Chef::Recipe.send(:include, ::Kubernetes::Helpers)
