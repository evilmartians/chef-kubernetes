require 'yaml'

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
        result = 'systemd' if n['init_package'] == 'systemd'
      end
      result
    end

    def kubelet_yaml(a = atts)
      a.to_hash.to_yaml.sub(/---\n/, '')
    end

    def container_runtime_endpoint(runtime = node['kubernetes']['container_runtime'])
      proto    = node['kubernetes'][runtime]['endpoint_proto']
      endpoint = node['kubernetes'][runtime]['endpoint']
      proto + endpoint
    end

    def kubelet_args
      options = Hash[node['kubernetes']['kubelet']['daemon_flags'].map { |k, v| [k.tr('_', '-'), v] }]
      options.store('hostname-override', k8s_hostname(node)) #  FIXME
      options.store('node-ip', k8s_ip(node)) # FIXME
      unless node['kubernetes']['container_runtime'] == 'docker'
        options.store('container-runtime-endpoint', container_runtime_endpoint)
      end
      options.sort_by { |k, v| k }.map { |k, v| v.nil? ? "--#{k}" : "--#{k}=#{v}" }
    end

    def proxy_args
      options = Hash[node['kubernetes']['proxy'].map { |k, v| [k.tr('_', '-'), v] }]
      options.store('hostname-override', k8s_hostname(node)) #  FIXME
      options.store('bind-address', k8s_ip(node)) # FIXME
      options.store('cluster-cidr', node['kubernetes']['cluster_cidr'])
      options['feature-gates'] = options['feature-gates'].map { |k, v| "#{k}=#{v}" }.join(',')
      options.sort_by { |k, v| k }.map { |k, v| v.nil? ? "--#{k}" : "--#{k}=#{v}" }
    end

    def scheduler_args
      options = Hash[node['kubernetes']['scheduler'].map { |k, v| [k.tr('_', '-'), v] }]
      options['feature-gates'] = options['feature-gates'].map { |k, v| "#{k}=#{v}" }.join(',')
      options.sort_by { |k, v| k }.map { |k, v| v.nil? ? "--#{k}" : "--#{k}=#{v}" }
    end

    def apiserver_args
      etcd_nodes = search(
        :node,
        "roles:#{node['etcd']['role']}"
      ).map { |node| k8s_ip(node) }

      etcd_servers = etcd_nodes.map do |addr|
        "#{node['etcd']['proto']}://#{addr}:#{node['etcd']['client_port']}"
      end.join ','

      if etcd_nodes.empty?
        etcd_servers = "#{node['etcd']['proto']}://#{k8s_ip(node)}:#{node['etcd']['client_port']}"
      end

      options = Hash[node['kubernetes']['api'].map { |k, v| [k.tr('_', '-'), v] }]
      options['feature-gates'] = options['feature-gates'].map { |k, v| "#{k}=#{v}" }.join(',')
      options.store('advertise-address', k8s_ip(node)) # FIXME
      options.store('etcd-servers', etcd_servers) # FIXME

      if node['kubernetes']['api']['endpoint_reconciler_type'] == 'master-count'
        master_nodes = search(:node, "roles:#{node['kubernetes']['roles']['master']}")
        master_nodes = [node] if master_nodes.empty?
        options.store('apiserver-count', master_nodes.size)
      end

      if node['kubernetes']['token_auth']
        options.store('token-auth-file', node['kubernetes']['token_auth_file'])
      end

      if node['kubernetes']['authorization']['mode'].include?('ABAC')
        options.store('authorization-policy-file', '/etc/kubernetes/authorization-policy.jsonl')
      end

      if node['kubernetes']['audit']['enabled']
        options.store('audit-log-maxbackup', node['kubernetes']['audit']['maxbackup'])
        options.store('audit-log-path', node['kubernetes']['audit']['log_file'])
      end

      options.sort_by { |k, v| k }.map { |k, v| v.nil? ? "--#{k}" : "--#{k}=#{v}" }
    end

    def controller_manager_args
      options = Hash[node['kubernetes']['controller_manager'].map { |k, v| [k.tr('_', '-'), v] }]
      options['feature-gates'] = options['feature-gates'].map { |k, v| "#{k}=#{v}" }.join(',')

      if node['kubernetes']['sdn'] == 'canal'
        options.store('allocate-node-cidrs', nil)
        options.store('node-cidr-mask-size', node['kubernetes']['node_cidr_mask_size'])
      end

      options.sort_by { |k, v| k }.map { |k, v| v.nil? ? "--#{k}" : "--#{k}=#{v}" }
    end

    def crio_args
      options = Hash[node['kubernetes']['crio']['daemon_flags'].map { |k, v| [k.tr('_', '-'), v] }]
      options.sort_by { |k, v| k }.map { |k, v| v.nil? ? "--#{k}" : "--#{k}=#{v}" }
    end

  end
end

Chef::Recipe.send(:include, ::Kubernetes::Helpers)
Chef::Resource.send(:include, ::Kubernetes::Helpers)
