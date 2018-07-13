default['kubernetes']['proxy']['kubeconfig']    = '/etc/kubernetes/system:kube-proxy_config.yaml'
default['kubernetes']['proxy']['feature_gates'] = node['kubernetes']['feature_gates']
