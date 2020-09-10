default['kubernetes']['container_runtime']                  = 'docker'
default['kubernetes']['roles']['master']                    = 'kubernetes_master'
default['kubernetes']['roles']['node']                      = 'kubernetes_node'
default['kubernetes']['install_via']                        = 'systemd' # other possible values are: static_pods
default['kubernetes']['databag']                            = 'kubernetes'
default['kubernetes']['version']                            = 'v1.18.8'
default['kubernetes']['keep_versions']                      = 3
default['kubernetes']['image']                              = 'gcr.io/google_containers/hyperkube'
default['kubernetes']['interface']                          = 'eth1'
default['kubernetes']['enable_firewall']                    = true
default['kubernetes']['register_as']                        = 'ip'
default['kubernetes']['proxy_mode']                         = 'iptables' # other possible values are: ipvs
default['kubernetes']['use_sdn']                            = true
default['kubernetes']['sdn']                                = 'weave'
default['kubernetes']['master']                             = '127.0.0.1'
default['kubernetes']['cluster_name']                       = 'kubernetes'
default['kubernetes']['cluster_dns']                        = ['10.222.222.222']
default['kubernetes']['cluster_domain']                     = 'kubernetes.local'
default['kubernetes']['cluster_cidr']                       = '192.168.0.0/16'
default['kubernetes']['node_cidr_mask_size']                = 24
default['kubernetes']['use_cluster_dns_systemwide']         = false
default['kubernetes']['kubeconfig']                         = '/etc/kubernetes/kubeconfig.yaml'
default['kubernetes']['ssl']['keypairs']                    = %w(apiserver ca-cluster_signing ca-service_account ca-requestheader front_proxy_client kubelet_client ca-etcd_server etcd_client scheduler controller_manager)
default['kubernetes']['tls_cert_file']                      = '/etc/kubernetes/ssl/apiserver.pem'
default['kubernetes']['tls_private_key_file']               = '/etc/kubernetes/ssl/apiserver-key.pem'
default['kubernetes']['client_ca_file']                     = '/etc/kubernetes/ssl/ca-cluster_signing.pem'
default['kubernetes']['requestheader_client_ca_file']       = '/etc/kubernetes/ssl/ca-requestheader.pem'
default['kubernetes']['requestheader_client_ca_key']        = '/etc/kubernetes/ssl/ca-requestheader-key.pem'
default['kubernetes']['service_account_cert_file']          = '/etc/kubernetes/ssl/ca-service_account.pem'
default['kubernetes']['service_account_key_file']           = '/etc/kubernetes/ssl/ca-service_account-key.pem'
default['kubernetes']['cluster_signing_cert_file']          = '/etc/kubernetes/ssl/ca-cluster_signing.pem'
default['kubernetes']['cluster_signing_key_file']           = '/etc/kubernetes/ssl/ca-cluster_signing-key.pem'
default['kubernetes']['cluster_signing_kube_apiserver_client_cert_file']  = node['kubernetes']['cluster_signing_cert_file']
default['kubernetes']['cluster_signing_kube_apiserver_client_key_file']   = node['kubernetes']['cluster_signing_key_file']
default['kubernetes']['cluster_signing_kubelet_client_cert_file']         = node['kubernetes']['cluster_signing_cert_file']
default['kubernetes']['cluster_signing_kubelet_client_key_file']          = node['kubernetes']['cluster_signing_key_file']
default['kubernetes']['cluster_signing_kubelet_serving_cert_file']        = node['kubernetes']['cluster_signing_cert_file']
default['kubernetes']['cluster_signing_kubelet_serving_key_file']         = node['kubernetes']['cluster_signing_key_file']
default['kubernetes']['cluster_signing_legacy_unknown_cert_file']         = node['kubernetes']['cluster_signing_cert_file']
default['kubernetes']['cluster_signing_legacy_unknown_key_file']          = node['kubernetes']['cluster_signing_key_file']
default['kubernetes']['proxy_client_cert_file']             = '/etc/kubernetes/ssl/front_proxy_client.pem'
default['kubernetes']['proxy_client_key_file']              = '/etc/kubernetes/ssl/front_proxy_client-key.pem'
default['kubernetes']['kubelet_client_cert_file']           = '/etc/kubernetes/ssl/kubelet_client.pem'
default['kubernetes']['kubelet_client_key_file']            = '/etc/kubernetes/ssl/kubelet_client-key.pem'
default['kubernetes']['etcd_server_cafile']                 = '/etc/kubernetes/ssl/ca-etcd_server.pem'
default['kubernetes']['etcd_peer_cafile']                   = '/etc/kubernetes/ssl/ca-etcd_peer.pem'
default['kubernetes']['etcd_server_cert_file']              = '/etc/kubernetes/ssl/etcd_server.pem'
default['kubernetes']['etcd_peer_cert_file']                = '/etc/kubernetes/ssl/etcd_peer.pem'
default['kubernetes']['etcd_server_key_file']               = '/etc/kubernetes/ssl/etcd_server-key.pem'
default['kubernetes']['etcd_peer_key_file']                 = '/etc/kubernetes/ssl/etcd_peer-key.pem'
default['kubernetes']['etcd_client_cert_file']              = '/etc/kubernetes/ssl/etcd_client.pem'
default['kubernetes']['etcd_client_key_file']               = '/etc/kubernetes/ssl/etcd_client-key.pem'
default['kubernetes']['scheduler_cert_file']                = '/etc/kubernetes/ssl/scheduler.pem'
default['kubernetes']['scheduler_key_file']                 = '/etc/kubernetes/ssl/scheduler-key.pem'
default['kubernetes']['controller_manager_cert_file']       = '/etc/kubernetes/ssl/controller_manager.pem'
default['kubernetes']['controller_manager_key_file']        = '/etc/kubernetes/ssl/controller_manager-key.pem'
default['kubernetes']['token_auth']                         = false
default['kubernetes']['token_auth_file']                    = '/etc/kubernetes/known_tokens.csv'
default['kubernetes']['docker']['endpoint']                 = 'unix:///var/run/docker.sock'
default['kubernetes']['cgroupdriver']                       = 'systemd'
default['kubernetes']['logging_format']                     = 'text'
default['kubernetes']['audit']['enabled']                   = true
default['kubernetes']['audit']['log_path']                  = '/var/log/kubernetes/audit.log'
default['kubernetes']['audit']['log_format']                = 'json' # Known formats are legacy,json.
default['kubernetes']['audit']['log_mode']                  = 'blocking' # Known modes are batch,blocking.
default['kubernetes']['audit']['log_maxbackup']             = 3
default['kubernetes']['audit']['log_maxsize']               = 10
default['kubernetes']['audit']['policy_file']               = '/etc/kubernetes/audit-policy.yaml'
default['kubernetes']['audit_webhook']['enabled']           = false
default['kubernetes']['audit_webhook']['config_file']       = '/etc/kubernetes/audit-webhook.yaml'
default['kubernetes']['audit_webhook']['initial_backoff']   = '10s'
default['kubernetes']['audit_webhook']['version']           = 'audit.k8s.io/v1'
default['kubernetes']['audit_webhook']['mode']              = 'batch' # Known modes are batch,blocking,blocking-strict.
default['kubernetes']['audit_webhook_config']['server']     = ''
default['kubernetes']['feature_gates']                      = {
  'TTLAfterFinished'          => true,
  'ServiceTopology'           => true,
  'EndpointSliceProxying'     => true,
  'ConfigurableFSGroupPolicy' => true,
  'EphemeralContainers'       => true,
  'CSIStorageCapacity'        => true,
  'GenericEphemeralVolume'    => true,
}
default['kubernetes']['packages']['storage_url']            = "https://storage.googleapis.com/kubernetes-release/release/#{node['kubernetes']['version']}/bin/linux/amd64/"
default['kubernetes']['checksums']['apiserver']             = 'fcab24dd3e74438f3bb2badb8d9ddfaff0798eaae5fd6c7cbb709bf549535a1d'
default['kubernetes']['checksums']['controller-manager']    = '3e3d109334e4cbd90fe75255b02d4909e579d5acb35dd7327a2bbbd9e1ee344f'
default['kubernetes']['checksums']['proxy']                 = 'd4decc5b69330744cd790279d87bf2d5151b1a8d4a131dc6d787f9d81abd20b7'
default['kubernetes']['checksums']['scheduler']             = '2a130b906cd9f25cc126325a60657131d00685c7c159f6f22975119fd07b9f78'
default['kubernetes']['checksums']['kubectl']               = 'a076f5eff0710de94d1eb77bee458ea43b8f4d9572bbb3a3aec1edf0dde0a3e7'
default['kubernetes']['checksums']['kubelet']               = 'a4116675ac52bf80e224fba8ff6db6f2d7aed192bf6fffd5f8e4d5efb4368f31'
default['kubernetes']['addon_manager']['version']           = 'v9.1.1'
default['kubernetes']['multimaster']['access_via']          = 'haproxy' # other possible values are: direct, dns
default['kubernetes']['multimaster']['haproxy_url']         = '127.0.0.1'
default['kubernetes']['multimaster']['haproxy_port']        = 6443
default['kubernetes']['multimaster']['dns_name']            = ''
default['kubernetes']['encryption']                         = 'aescbc'
default['kubernetes']['cni']['plugins_version']             = '0.8.7'
default['kubernetes']['cni']['plugins'] = {
  'bandwidth'   => true,
  'bridge'	=> true,
  'dhcp'	=> true,
  'firewall'    => true,
  'flannel'	=> true,
  'host-device'	=> true,
  'host-local'	=> true,
  'ipvlan'	=> true,
  'loopback'	=> true,
  'macvlan'	=> true,
  'portmap'	=> true,
  'ptp'	        => true,
  'sbr'         => true,
  'static'      => true,
  'tuning'	=> true,
  'vlan'	=> true,
}
default['kubernetes']['node']['packages'] = {
  'iptables'            => true,
  'ebtables'            => true,
  'socat'               => true,
  'ethtool'             => true,
  'kmod'                => true,
  'tcpd'                => true,
  'dbus'                => true,
  'apt-transport-https' => true,
  'conntrack'           => true,
}
