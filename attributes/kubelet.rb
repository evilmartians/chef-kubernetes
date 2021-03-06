default['kubernetes']['kubelet']['daemon_flags']['config']                       = '/etc/kubernetes/kubeletconfig.yaml'
default['kubernetes']['kubelet']['daemon_flags']['bootstrap_kubeconfig']         = '/etc/kubernetes/kubeconfig-bootstrap.yaml'
default['kubernetes']['kubelet']['daemon_flags']['cert_dir']                     = '/etc/kubernetes/ssl'
default['kubernetes']['kubelet']['daemon_flags']['kubeconfig']                   = '/etc/kubernetes/kubelet.yaml'
default['kubernetes']['kubelet']['daemon_flags']['v']                            = 2
default['kubernetes']['kubelet']['daemon_flags']['network_plugin']               = 'cni'
default['kubernetes']['kubelet']['daemon_flags']['register_node']                = true
default['kubernetes']['kubelet']['daemon_flags']['cni_cache_dir']                = '/var/lib/cni/cache'
# default['kubernetes']['kubelet']['daemon_flags']['authentication_token_webhook'] = nil # set nil if key doesn't have a parameters
default['kubernetes']['kubelet']['daemon_flags']['container_runtime']            = node['kubernetes']['container_runtime'] == 'docker' ? 'docker' : 'remote'

default['kubernetes']['kubelet']['config']['staticPodPath']                          = '/etc/kubernetes/manifests'
default['kubernetes']['kubelet']['config']['authentication']['x509']['clientCAFile'] = node['kubernetes']['client_ca_file']
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
default['kubernetes']['kubelet']['config']['cpuCFSQuotaPeriod']                      = '10ms'
default['kubernetes']['kubelet']['config']['systemReserved']['cpu']                  = '100m'
default['kubernetes']['kubelet']['config']['systemReserved']['memory']               = '100Mi'
default['kubernetes']['kubelet']['config']['kubeReserved']['cpu']                    = '100m'
default['kubernetes']['kubelet']['config']['kubeReserved']['memory']                 = '100Mi'
default['kubernetes']['kubelet']['config']['enableSystemLogHandler']                 = true
default['kubernetes']['kubelet']['config']['enableDebuggingHandlers']                = true
default['kubernetes']['kubelet']['config']['kernelMemcgNotification']                = true
default['kubernetes']['kubelet']['config']['nodeStatusMaxImages']                    = 50
default['kubernetes']['kubelet']['config']['topologyManagerScope']                   = 'container'
default['kubernetes']['kubelet']['config']['loggingFormat']                          = node['kubernetes']['logging_format']
if node['kubernetes']['kubelet']['config']['featureGates']['GracefulNodeShutdown']
  default['kubernetes']['kubelet']['config']['ShutdownGracePeriod']                  = '30s'
  default['kubernetes']['kubelet']['config']['ShutdownGracePeriodCriticalPods']      = '10s'
end
