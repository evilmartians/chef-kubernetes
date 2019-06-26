default['kubernetes']['kubelet']['daemon_flags']['config']                       = '/etc/kubernetes/kubeletconfig.yaml'
default['kubernetes']['kubelet']['daemon_flags']['bootstrap_kubeconfig']         = '/etc/kubernetes/kubeconfig-bootstrap.yaml'
default['kubernetes']['kubelet']['daemon_flags']['cert_dir']                     = '/etc/kubernetes/ssl'
default['kubernetes']['kubelet']['daemon_flags']['kubeconfig']                   = '/etc/kubernetes/kubelet.yaml'
default['kubernetes']['kubelet']['daemon_flags']['v']                            = 2
default['kubernetes']['kubelet']['daemon_flags']['network_plugin']               = 'cni'
default['kubernetes']['kubelet']['daemon_flags']['register_node']                = true
# default['kubernetes']['kubelet']['daemon_flags']['authentication_token_webhook'] = nil # set nil if key doesn't have a parameters
default['kubernetes']['kubelet']['daemon_flags']['container_runtime']            = node['kubernetes']['container_runtime'] == 'docker' ? 'docker' : 'remote'

default['kubernetes']['kubelet']['config']['staticPodPath']                          = '/etc/kubernetes/manifests'
default['kubernetes']['kubelet']['config']['authentication']['x509']['clientCAFile'] = '/etc/kubernetes/ssl/ca.pem'
default['kubernetes']['kubelet']['config']['authentication']['webhook']['enabled']   = true
default['kubernetes']['kubelet']['config']['authentication']['webhook']['cacheTTL']  = '2m0s'
default['kubernetes']['kubelet']['config']['authentication']['anonymous']['enabled'] = false
default['kubernetes']['kubelet']['config']['authorization']['mode']                  = 'Webhook'
default['kubernetes']['kubelet']['config']['clusterDNS']                             = node['kubernetes']['cluster_dns']
default['kubernetes']['kubelet']['config']['featureGates']                           = node['kubernetes']['feature_gates']
default['kubernetes']['kubelet']['config']['nodeStatusUpdateFrequency']              = '4s'
default['kubernetes']['kubelet']['config']['clusterDomain']                          = node['kubernetes']['cluster_domain']
default['kubernetes']['kubelet']['config']['imageGCLowThresholdPercent']             = 70
default['kubernetes']['kubelet']['config']['imageGCHighThresholdPercent']            = 80
default['kubernetes']['kubelet']['config']['failSwapOn']                             = false
default['kubernetes']['kubelet']['config']['cgroupDriver']                           = node['kubernetes']['cgroupdriver']
default['kubernetes']['kubelet']['config']['readOnlyPort']                           = 10255
default['kubernetes']['kubelet']['config']['serverTLSBootstrap']                     = true
default['kubernetes']['kubelet']['config']['rotateCertificates']                     = true
