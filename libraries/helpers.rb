class Chef
  # Few helpers for Kubernetes installation.
  class Recipe
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
