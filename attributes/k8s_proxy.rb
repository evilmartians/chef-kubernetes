default['kubernetes']['proxy']['global']['kubeconfig']         = '/etc/kubernetes/system:kube-proxy_config.yaml'
default['kubernetes']['proxy']['global']['feature_gates']      = node['kubernetes']['feature_gates']
default['kubernetes']['proxy']['ipvs']['ipvs_sync_period']     = '30s'
default['kubernetes']['proxy']['ipvs']['ipvs_scheduler']       = 'rr'
default['kubernetes']['proxy']['ipvs']['ipvs_exclude_cidrs']   = ''
default['kubernetes']['proxy']['metrics_port']                 = 10249
