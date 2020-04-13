default['kubernetes']['container_runtime']                  = 'docker'
default['kubernetes']['roles']['master']                    = 'kubernetes_master'
default['kubernetes']['roles']['node']                      = 'kubernetes_node'
default['kubernetes']['install_via']                        = 'systemd' # other possible values are: static_pods
default['kubernetes']['databag']                            = 'kubernetes'
default['kubernetes']['version']                            = 'v1.17.4'
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
default['kubernetes']['cgroupdriver']                       = 'cgroupfs'
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
}
default['kubernetes']['packages']['storage_url']            = "https://storage.googleapis.com/kubernetes-release/release/#{node['kubernetes']['version']}/bin/linux/amd64/"
default['kubernetes']['checksums']['apiserver']             = '1df7d178f1eef98a7298acb73d036915c604214dc67d923506d25d492dc562af'
default['kubernetes']['checksums']['controller-manager']    = 'f30a6f6410aa77c657743daccfb85256cb1ff52c3b446d9450437dfa86af7968'
default['kubernetes']['checksums']['proxy']                 = '775b07ce46be3996437fde81ec3724177cbaff8e202bac8a647bdcc8e2e3c00b'
default['kubernetes']['checksums']['scheduler']             = '56d4b8b655a765dbcfc21aafc6c2aea70c1ed9e90654755350f25e1c0efe3954'
default['kubernetes']['checksums']['kubectl']               = '465b2d2bd7512b173860c6907d8127ee76a19a385aa7865608e57a5eebe23597'
default['kubernetes']['checksums']['kubelet']               = 'f3a427ddf610b568db60c8d47565041901220e1bbe257614b61bb4c76801d765'
default['kubernetes']['addon_manager']['version']           = 'v9.0.2'
default['kubernetes']['multimaster']['access_via']          = 'haproxy' # other possible values are: direct, dns
default['kubernetes']['multimaster']['haproxy_url']         = '127.0.0.1'
default['kubernetes']['multimaster']['haproxy_port']        = 6443
default['kubernetes']['multimaster']['dns_name']            = ''
default['kubernetes']['encryption']                         = 'aescbc'
default['kubernetes']['cni']['plugins_version']             = '0.8.5'
default['kubernetes']['cni']['plugins'] = {
  'bridge'	=> true,
  'dhcp'	=> true,
  'flannel'	=> true,
  'host-device'	=> true,
  'host-local'	=> true,
  'ipvlan'	=> true,
  'loopback'	=> true,
  'macvlan'	=> true,
  'portmap'	=> true,
  'ptp'	        => true,
  'sample'	=> true,
  'tuning'	=> true,
  'vlan'	=> true,
  'bandwidth'   => true,
  'firewall'    => true,
  'sbr'         => true,
  'static'      => true,
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
