name 'kubernetes_master'
description 'Kubernetes master node'
run_list 'recipe[kubernetes::master]'
override_attributes(
  kubernetes: {
    cluster_name: 'example',
    cluster_dns: ['192.168.222.222'],
    cluster_cidr: '192.168.0.0/17',
    api: {
      'service_cluster_ip_range' => '192.168.128.0/17'
    },
    weave: {
      use_scope: false,
      deploy_via: 'daemonset'
    },
    dns: { deploy_via: 'deployment' },
    token_auth: true,
    addons: {
      coredns: {
        requests: {
          cpu: '200m'
        },
        limits: {
          cpu: '200m'
        }
      },
      dns: {
        controller: 'coredns',
        antiaffinity_type: 'requiredDuringSchedulingIgnoredDuringExecution'
      }
    }
  }
)
