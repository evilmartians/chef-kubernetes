name 'kubernetes_node'
description 'kubernetes node'
run_list 'recipe[kubernetes]'
override_attributes(
  docker: {
    'settings' => {
      'storage-driver' => 'aufs',
      'log-driver' => 'json-file',
      'log-opts' => {
        'max-size' => '100m',
        'max-file' => '5'
      }
    }
  },
  kubernetes: {
    cluster_name: 'example',
    cluster_dns: ['192.168.222.222'],
    token_auth: true,
    api:   { 'service_cluster_ip_range' => '192.168.128.0/17' },
    weave: {
      network: '192.168.0.0/17',
      use_scope: false
    }
  }
)
