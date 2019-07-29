
# kubernetes-cookbook
![alt text](evil_k8s.png)

Google Kubernetes installer for Ubuntu

## Supported Platforms

- Ubuntu

### Attributes ###
###### default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['kubernetes']['container_runtime']</tt></td>
    <td>String</td>
    <td>type of engine</td>
    <td><tt>docker</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['roles']['master']</tt></td>
    <td>String</td>
    <td>role name for master servers</td>
    <td><tt>kubernetes_master</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['roles']['node']</tt></td>
    <td>String</td>
    <td>role name for minions</td>
    <td><tt>kubernetes_node</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['install_via']</tt></td>
    <td>String</td>
    <td>type of installation</td>
    <td><tt>systemd</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['databag']</tt></td>
    <td>String</td>
    <td>default chef data_bag</td>
    <td><tt>kubernetes</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['version']</tt></td>
    <td>String</td>
    <td>kubernetes version</td>
    <td><tt>v1.15.0</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['keep_versions']</tt></td>
    <td>Int</td>
    <td></td>
    <td><tt>3</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['image']</tt></td>
    <td>String</td>
    <td>hyperkube image name</td>
    <td><tt>gcr.io/google_containers/hyperkube</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['interface']</tt></td>
    <td>String</td>
    <td>default interface</td>
    <td><tt>eth1</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['enable_firewall']</tt></td>
    <td>Boolean</td>
    <td>Enable firewall</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['register_as']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>ip</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['proxy_mode']</tt></td>
    <td>String</td>
    <td>Which proxy mode to use: iptables or ipvs.</td>
    <td><tt>iptables</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['use_sdn']</tt></td>
    <td>Boolean</td>
    <td>Use sdn</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['sdn']</tt></td>
    <td>String</td>
    <td>Type of sdn</td>
    <td><tt>weave</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['master']</tt></td>
    <td>String</td>
    <td>k8s master address</td>
    <td><tt>127.0.0.1</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['cluster_name']</tt></td>
    <td>String</td>
    <td>cluster name</td>
    <td><tt>kubernetes</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['cluster_dns']</tt></td>
    <td>Array</td>
    <td>cluster dns</td>
    <td><tt>10.222.222.222</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['cluster_domain']</tt></td>
    <td>String</td>
    <td>cluster dns name</td>
    <td><tt>kubernetes.local</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['cluster_cidr']</tt></td>
    <td>String</td>
    <td>cidr</td>
    <td><tt>192.168.0.0/16</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['node_cidr_mask_size']</tt></td>
    <td>Int</td>
    <td>cidr mask size</td>
    <td><tt>24</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['use_cluster_dns_systemwide']</tt></td>
    <td>Boolean</td>
    <td>dns systemwide</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['ssl']['keypairs']</tt></td>
    <td>Array</td>
    <td>ssl keypairs</td>
    <td><tt>['apiserver', 'ca']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['ssl']['ca']['public_key']</tt></td>
    <td>String</td>
    <td>ca public_key path</td>
    <td><tt>/etc/kubernetes/ssl/ca.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['ssl']['ca']['private_key']</tt></td>
    <td>String</td>
    <td>ca private_key path</td>
    <td><tt>/etc/kubernetes/ssl/ca-key.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['ssl']['apiserver']['public_key']</tt></td>
    <td>String</td>
    <td>apiserver public_key path</td>
    <td><tt>/etc/kubernetes/ssl/apiserver.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['ssl']['apiserver']['private_key']</tt></td>
    <td>String</td>
    <td>apiserver private_key path</td>
    <td><tt>/etc/kubernetes/ssl/apiserver-key.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubeconfig']</tt></td>
    <td>String</td>
    <td>kubeconfig path</td>
    <td><tt>/etc/kubernetes/kubeconfig.yaml</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['tls_cert_file']</tt></td>
    <td>String</td>
    <td>tls_cert_file path</td>
    <td><tt>/etc/kubernetes/ssl/apiserver.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['tls_private_key_file']</tt></td>
    <td>String</td>
    <td>tls private key file</td>
    <td><tt>/etc/kubernetes/ssl/apiserver-key.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['client_ca_file']</tt></td>
    <td>String</td>
    <td>client_ca_file path</td>
    <td><tt>/etc/kubernetes/ssl/ca.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['requestheader_client_ca_file']</tt></td>
    <td>String</td>
    <td>Root certificate bundle to use to verify client certificates on incoming requests before trusting usernames in headers</td>
    <td><tt>/etc/kubernetes/ssl/ca.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['cluster_signing_cert_file']</tt></td>
    <td>String</td>
    <td>cluster_signing_cert_file path</td>
    <td><tt>/etc/kubernetes/ssl/ca.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['cluster_signing_key_file']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>/etc/kubernetes/ssl/ca-key.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['token_auth']</tt></td>
    <td>Boolean</td>
    <td>token auth</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['token_auth_file']</tt></td>
    <td>String</td>
    <td>tokens file</td>
    <td><tt>/etc/kubernetes/known_tokens.csv</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['docker']</tt></td>
    <td>String</td>
    <td>path to docker socket</td>
    <td><tt>unix:///var/run/docker.sock</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes'][cgroupdriver']</tt></td>
    <td>String</td>
    <td>Driver that the kubelet uses to manipulate cgroups on the host.</td>
    <td><tt>cgroupfs</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['feature_gates']</tt></td>
    <td>Hash</td>
    <td>feature gates</td>
    <td><tt>'VolumeSubpathEnvExpansion' => true, 'TTLAfterFinished' => true</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['audit']['enabled']</tt></td>
    <td>Boolean</td>
    <td>enable audit</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['audit']['policy_file']</tt></td>
    <td>String</td>
    <td>Path to the file that defines the audit policy configuration</td>
    <td><tt>/etc/kubernetes/audit-policy.yaml</tt></td>
  </tr>
  <tr>
  <tr>
    <td><tt>['kubernetes']['audit']['log_path']</tt></td>
    <td>String</td>
    <td>If set, all requests coming to the apiserver will be logged to this file</td>
    <td><tt>/var/log/kubernetes/audit.log</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['audit']['log_format']</tt></td>
    <td>String</td>
    <td>Format of saved audits. "legacy" indicates 1-line text format for each event. "json" indicates structured json format</td>
    <td><tt>json</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['audit']['log_mode']</tt></td>
    <td>String</td>
    <td>Strategy for sending audit events. Blocking indicates sending events should block server responses. Batch causes the backend to buffer and write events asynchronously</td>
    <td><tt>blocking</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['audit']['log_maxbackup']</tt></td>
    <td>Int</td>
    <td>The maximum number of old audit log files to retain</td>
    <td><tt>3</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['audit']['log_maxsize']</tt></td>
    <td>Int</td>
    <td>The maximum size in megabytes of the audit log file before it gets rotated</td>
    <td><tt>10</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['audit_webhook']['enabled']</tt></td>
    <td>Boolean</td>
    <td>enable [audit webhook backend](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#webhook-backend)</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['audit_webhook']['config_file']</tt></td>
    <td>String</td>
    <td>Path to a kubeconfig formatted file that defines the audit webhook configuration.</td>
    <td><tt>/etc/kubernetes/audit-webhook.yaml</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['audit_webhook']['initial_backoff']</tt></td>
    <td>String</td>
    <td>The amount of time to wait before retrying the first failed request.</td>
    <td><tt>10s</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['audit_webhook']['version']</tt></td>
    <td>String</td>
    <td>API group and version used for serializing audit events written to webhook.</td>
    <td><tt>audit.k8s.io/v1</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['audit_webhook']['mode']</tt></td>
    <td>String</td>
    <td>Strategy for sending audit events. Blocking indicates sending events should block server responses. Batch causes the backend to buffer and write events asynchronously. Known modes are batch,blocking,blocking-strict.</td>
    <td><tt>batch</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['audit_webhook_config']['server']</tt></td>
    <td>String</td>
    <td>Audit server URL.</td>
    <td><tt>''</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['packages']['storage_url']</tt></td>
    <td>String</td>
    <td>packages storage</td>
    <td><tt>https://storage.googleapis.com/kubernetes-release/release/#{node['kubernetes']['version']}/bin/linux/amd64/</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['checksums']['apiserver']</tt></td>
    <td>String</td>
    <td>checksum</td>
    <td><tt>1852bfe86cfa96959ece2db5c70847c4e6b993caf0799ecc0d11c788ed366a56</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['checksums']['controller-manager']</tt></td>
    <td>String</td>
    <td>checksum</td>
    <td><tt>114e7d1b6ff44bab03ecc84959b76455372445b703661863a9f222bf710e35f0</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['checksums']['proxy']</tt></td>
    <td>String</td>
    <td>checksum</td>
    <td><tt>7670939861baeeca598bdfcbebc8f7e48f1c6fa73983c4d3f549e894757d2d2f</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['checksums']['scheduler']</tt></td>
    <td>String</td>
    <td>checksum</td>
    <td><tt>ad44f1c248ce0b6c35b7c7c66567d6e8085f785a130a6a26fd238411088fab5b</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['checksums']['kubectl']</tt></td>
    <td>String</td>
    <td>checksum</td>
    <td><tt>1bb4d3793fb0f9e1cfee86599e0f43ae5f15578a01b61011fe7c9488e114a00b</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['checksums']['kubelet']</tt></td>
    <td>String</td>
    <td>checksum</td>
    <td><tt>688d1167c5a8b37bb5f10e330ba43c15092f1d35dcc25929e84484c41a20319d</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addon_manager']['version']</tt></td>
    <td>String</td>
    <td>addon_manager version</td>
    <td><tt>v9.0</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['multimaster']['access_via']</tt></td>
    <td>String</td>
    <td>type of access</td>
    <td><tt>haproxy</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['multimaster']['haproxy_url']</tt></td>
    <td>String</td>
    <td>haproxy url</td>
    <td><tt>127.0.0.1</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['multimaster']['haproxy_port']</tt></td>
    <td>Int</td>
    <td>haproxy port</td>
    <td><tt>6443</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['multimaster']['dns_name']</tt></td>
    <td>String</td>
    <td>multimaster dns_name</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['cni']['plugins']</tt></td>
    <td>Hash</td>
    <td>cni plugins</td>
    <td><tt>See attributes/default.rb for this big hash</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['cni']['plugins_version']</tt></td>
    <td>String</td>
    <td>cni plugins version</td>
    <td><tt>0.8.1</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['encryption']</tt></td>
    <td>String</td>
    <td>encryption</td>
    <td><tt>aescbc</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['node']['packages']</tt></td>
    <td>Hash</td>
    <td>default node packages</td>
    <td><tt>See attributes/default.rb for more information</tt></td>
  </tr>
</table>

###### kubelet

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['daemon_flags']['config']</tt></td>
    <td>String</td>
    <td>kubelet init config</td>
    <td><tt>/etc/kubernetes/kubeletconfig.yaml</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['daemon_flags']['bootstrap_kubeconfig']</tt></td>
    <td>String</td>
    <td>bootstrap config</td>
    <td><tt>/etc/kubernetes/kubeconfig-bootstrap.yaml</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['daemon_flags']['cert_dir']</tt></td>
    <td>String</td>
    <td>cert dir</td>
    <td><tt>/etc/kubernetes/ssl</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['daemon_flags']['kubeconfig'] </tt></td>
    <td>String</td>
    <td>kubeconfig</td>
    <td><tt>/etc/kubernetes/kubelet.yaml</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['daemon_flags']['allow_privileged']</tt></td>
    <td>Boolean</td>
    <td>allow run privileged pods</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['daemon_flags']['v'] </tt></td>
    <td>Integer</td>
    <td>log veribosity</td>
    <td><tt>2</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['daemon_flags']['network_plugin']</tt></td>
    <td>String</td>
    <td>network plugin</td>
    <td><tt>cni</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['daemon_flags']['register_node']</tt></td>
    <td>Boolean</td>
    <td>register node</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['config']['staticPodPath']</tt></td>
    <td>String</td>
    <td>pod manifests</td>
    <td><tt>/etc/kubernetes/manifests</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['config']['authentication']['x509']['clientCAFile']</tt></td>
    <td>String</td>
    <td>client ca file</td>
    <td><tt>/etc/kubernetes/ssl/ca.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['config']['authentication']['webhook']['enabled']</tt></td>
    <td>Boolean</td>
    <td>enable webhook</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['config']['authentication']['webhook']['cacheTTL']</tt></td>
    <td>String</td>
    <td>webhook cacheTTL</td>
    <td><tt>2m0s</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['config']['authentication']['anonymous']['enabled']</tt></td>
    <td>Boolean</td>
    <td>anonymous auth</td>
    <td><tt>fase</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['config']['authorization']['mode']</tt></td>
    <td>String</td>
    <td>auth mode</td>
    <td><tt>Webhook</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['config']['clusterDNS']</tt></td>
    <td>Array</td>
    <td>array of cluster dns ips</td>
    <td><tt>node['kubernetes']['cluster_dns']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['config']['featureGates']</tt></td>
    <td>Hash</td>
    <td>hash of feature gates</td>
    <td><tt>node['kubernetes']['feature_gates']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['config']['NodeStatusUpdateFrequency']</tt></td>
    <td>String</td>
    <td>NodeStatusUpdateFrequency</td>
    <td><tt>4s</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['config']['clusterDomain']</tt></td>
    <td>String</td>
    <td>cluster domain</td>
    <td><tt>node['kubernetes']['cluster_domain']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['config']['imageGCLowThresholdPercent']</tt></td>
    <td>Integer</td>
    <td>imageGCLowThresholdPercent</td>
    <td><tt>70</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['config']['imageGCHighThresholdPercent']</tt></td>
    <td>Integer</td>
    <td>imageGCHighThresholdPercent</td>
    <td><tt>80</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['config']['failSwapOn']</tt></td>
    <td>Boolean</td>
    <td>failSwapOn</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['config']['ReadOnlyPort']</tt></td>
    <td>Integer</td>
    <td>ReadOnlyPort</td>
    <td><tt>10255</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['config']['serverTLSBootstrap]</tt></td>
    <td>Boolean</td>
    <td>Server certificate bootstrap</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['kubelet']['config']['rotateCertificates']</tt></td>
    <td>Boolean</td>
    <td>Auto rotate the kubelet client certificates by requesting new certificates from the kube-apiserver when the certificate expiration approaches</td>
    <td><tt>true</tt></td>
  </tr>
</table>

###### crio
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['kubernetes']['crio']['version']</tt></td>
    <td>String</td>
    <td>CRIO binary version</td>
    <td><tt>1.15.0</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['crio']['endpoint']</tt></td>
    <td>String</td>
    <td>Path to UNIX socket for crio daemon to listen</td>
    <td><tt>/var/run/crio/crio.sock</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['crio']['config']['runtime']</tt></td>
    <td>String</td>
    <td>OCI compatible runtime used for trusted container workloads.</td>
    <td><tt>/usr/local/bin/runc</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['crio']['config']['untrusted_runtime']</tt></td>
    <td>String</td>
    <td>OCI compatible runtime used for untrusted container workloads.</td>
    <td><tt>/usr/local/bin/runsc</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['crio']['config']['conmon']</tt></td>
    <td>String</td>
    <td>Path to conmon binary</td>
    <td><tt>/usr/local/bin/conmon</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['crio']['config']['storage_driver']</tt></td>
    <td>String</td>
    <td>Storage driver</td>
    <td><tt>aufs</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['crio']['config']['stream_port']</tt></td>
    <td>Fixnum</td>
    <td>Port on which the stream server will listen</td>
    <td><tt>10010</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['crio']['config']['runroot']</tt></td>
    <td>String</td>
    <td>Path to the "run directory". CRIO stores all of its state in this directory.</td>
    <td><tt>/var/run/containers/storage</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['crio']['config']['root']</tt></td>
    <td>String</td>
    <td>Path to the "root directory". CRIO stores all of its data, including container images, in this directory.</td>
    <td><tt>/var/lib/containers/storage</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['crio']['config']['log_level']</tt></td>
    <td>String</td>
    <td>Log messages above specified level: debug, info, warn, error, fatal or panic</td>
    <td><tt>info</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['crio']['daemon_flags']['log_format']</tt></td>
    <td>String</td>
    <td>Format used by logs</td>
    <td><tt>text</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['crio']['daemon_flags']['profile']</tt></td>
    <td>Boolean</td>
    <td>Enable pprof remote profiler on localhost:6060</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['crio']['daemon_flags']['enable_metrics']</tt></td>
    <td>Boolean</td>
    <td>Enable prometheus-compatible metrics endpoint for the server</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['crio']['daemon_flags']['metrics_port']</tt></td>
    <td>Fixnum</td>
    <td>Port for the metrics endpoint</td>
    <td><tt>9090</tt></td>
  </tr>
</table>


###### addons
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['dns']['controller']</tt></td>
    <td>String</td>
    <td>dns controller</td>
    <td><tt>coredns</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['dns']['antiaffinity_type']</tt></td>
    <td>String</td>
    <td>antiaffinity type</td>
    <td><tt>preferredDuringSchedulingIgnoredDuringExecution</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['dns']['antiaffinity_weight']</tt></td>
    <td>Int</td>
    <td>antiaffinity weight</td>
    <td><tt>100</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['kubedns']['dns_forward_max']</tt></td>
    <td>Int</td>
    <td>dns forward max</td>
    <td><tt>150</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['kubedns']['version']</tt></td>
    <td>String</td>
    <td>kubedns version</td>
    <td><tt>1.14.10</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['kubedns']['limits']['cpu']</tt></td>
    <td>String</td>
    <td>kubedns cpu limits</td>
    <td><tt>100m</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['kubedns']['limits']['memory']</tt></td>
    <td>String</td>
    <td>kubedns memory limits</td>
    <td><tt>170Mi</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['kubedns']['requests']['cpu']</tt></td>
    <td>String</td>
    <td>kubedns requests cpu</td>
    <td><tt>100m</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['kubedns']['requests']['memory']</tt></td>
    <td>String</td>
    <td>kubedns requests memory</td>
    <td><tt>70Mi</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['coredns']['version']</tt></td>
    <td>String</td>
    <td>coredns version</td>
    <td><tt>'1.5.1'</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['coredns']['limits']['cpu']</tt></td>
    <td>String</td>
    <td>coredns cpu limits</td>
    <td><tt>100m</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['coredns']['limits']['memory']</tt></td>
    <td>String</td>
    <td>coredns memory limits</td>
    <td><tt>256Mi</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['coredns']['requests']['cpu']</tt></td>
    <td>String</td>
    <td>coredns cpu requests</td>
    <td><tt>100m</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['coredns']['requests']['memory']</tt></td>
    <td>String</td>
    <td>coredns memory requests</td>
    <td><tt>256Mi</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['coredns']['log']</tt></td>
    <td>Boolean</td>
    <td>enable coredns log</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['coredns']['hosts']</tt></td>
    <td>Array</td>
    <td>Enable CoreDNS `hosts` pluging and add array elements as inline host entries</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['npd']['enabled']</tt></td>
    <td>Boolean</td>
    <td>enable node problem detector addon</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['npd']['version']</tt></td>
    <td>String</td>
    <td>node problem detector version</td>
    <td><tt>0.5.0</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['npd']['address']</tt></td>
    <td>String</td>
    <td>address to bind the node problem detector server</td>
    <td><tt>0.0.0.0</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['npd']['port']</tt></td>
    <td>Fixnum</td>
    <td>port to bind the node problem detector server</td>
    <td><tt>20256</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['npd']['log_level']</tt></td>
    <td>Fixnum</td>
    <td>log level for V logs</td>
    <td><tt>0</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['addons']['npd']['system_log_monitors']</tt></td>
    <td>Array</td>
    <td>List of paths to system log monitor config files</td>
    <td><tt>['/config/kernel-monitor.json', '/config/kernel-monitor-filelog.json', '/config/docker-monitor.json', '/config/docker-monitor-filelog.json']</tt></td>
  </tr>
</table>

###### authorization
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['kubernetes']['authorization']['admin_groups']</tt></td>
    <td>Array</td>
    <td>admin groups</td>
    <td><tt>['admins']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['authorization']['mode']</tt></td>
    <td>String</td>
    <td>authorization mode</td>
    <td><tt>None,RBAC</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['authorization']['policies']</tt></td>
    <td>Array</td>
    <td>auth policies</td>
    <td><tt>See attributes/authorization.rb</tt></td>
  </tr>
</table>

###### deis
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['kubernetes']['deis']['enabled']</tt></td>
    <td>Boolean</td>
    <td>enable deis</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['deis']['route_via']</tt></td>
    <td>String</td>
    <td>route</td>
    <td><tt>haproxy</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['deis']['builder']['port']</tt></td>
    <td>Int</td>
    <td>builder port</td>
    <td><tt>2222</tt></td>
  </tr>
</table>

###### docker
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['docker']['built-in']</tt></td>
    <td>Boolean</td>
    <td>enable built-in docker installation</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['docker']['version']</tt></td>
    <td>String</td>
    <td>default daemon version</td>
    <td><tt>18.09.8~3-0</tt></td>
  </tr>
  <tr>
    <td><tt>['docker']['deb_version']</tt></td>
    <td>String</td>
    <td>Debian package version number format</td>
    <td><tt>5</tt></td>
  </tr>
  <tr>
    <td><tt>['docker']['settings']['storage-driver']</tt></td>
    <td>String</td>
    <td>defalt storage driver</td>
    <td><tt>aufs</tt></td>
  </tr>
  <tr>
    <td><tt>['docker']['settings']['live-restore']</tt></td>
    <td>Boolean</td>
    <td>live restore</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['docker']['settings']['iptables']</tt></td>
    <td>Boolean</td>
    <td>iptables</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['docker']['settings']['ip-masq']</tt></td>
    <td>Boolean</td>
    <td>ip masq</td>
    <td><tt>false</tt></td>
  </tr>
</table>

###### etcd
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['etcd']['version']</tt></td>
    <td>String</td>
    <td>version</td>
    <td><tt>v3.3.11</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['image']</tt></td>
    <td>String</td>
    <td>image</td>
    <td><tt>quay.io/coreos/etcd</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['trusted_ca_file']</tt></td>
    <td>String</td>
    <td>trusted_ca_file</td>
    <td><tt>/etc/kubernetes/ssl/ca.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['client_cert_auth']</tt></td>
    <td>String</td>
    <td>client_cert_auth</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['key_file']</tt></td>
    <td>String</td>
    <td>key file</td>
    <td><tt>/etc/kubernetes/ssl/apiserver-key.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['cert_file']</tt></td>
    <td>String</td>
    <td>cert file</td>
    <td><tt>/etc/kubernetes/ssl/apiserver.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['peer_trusted_ca_file']</tt></td>
    <td>String</td>
    <td>trusted ca</td>
    <td><tt>/etc/kubernetes/ssl/ca.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['peer_client_cert_auth']</tt></td>
    <td>String</td>
    <td>cert auth</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['peer_key_file']</tt></td>
    <td>String</td>
    <td>key file</td>
    <td><tt>/etc/kubernetes/ssl/apiserver-key.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['peer_cert_file']</tt></td>
    <td>String</td>
    <td>cert file</td>
    <td><tt>/etc/kubernetes/ssl/apiserver.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['server_port']</tt></td>
    <td>Int</td>
    <td>server port</td>
    <td><tt>2380</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['client_port']</tt></td>
    <td>Int</td>
    <td>client port</td>
    <td><tt>2379</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['data_dir']</tt></td>
    <td>String</td>
    <td>data dir</td>
    <td><tt>/var/lib/etcd</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['wal_dir']</tt></td>
    <td>String</td>
    <td>wal_dir</td>
    <td><tt>/var/lib/etcd/member/wal</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['proto']</tt></td>
    <td>String</td>
    <td>proto</td>
    <td><tt>http</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['binary']</tt></td>
    <td>String</td>
    <td>binary</td>
    <td><tt>/usr/local/bin/etcd</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['user']</tt></td>
    <td>String</td>
    <td>etcd user</td>
    <td><tt>etcd</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['group']</tt></td>
    <td>String</td>
    <td>etcd group</td>
    <td><tt>etcd</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['initial_cluster_token']</tt></td>
    <td>String</td>
    <td>initial cluster token</td>
    <td><tt>etcd-cluster</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['initial_cluster_state']</tt></td>
    <td>String</td>
    <td>initial cluster state</td>
    <td><tt>new</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['role']</tt></td>
    <td>String</td>
    <td>role name</td>
    <td><tt>etcd</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd']['default_service_name']</tt></td>
    <td>Boolean</td>
    <td>Set default service name like etcd.service</td>
    <td><tt>true</tt></td>
  </tr>

</table>

###### firewall
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['firewall']['allow_ssh']</tt></td>
    <td>Boolean</td>
    <td>allow_ssh</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['firewall']['allow_loopback']</tt></td>
    <td>Boolean</td>
    <td>allow loopback</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['firewall']['allow_icmp']</tt></td>
    <td>Boolean</td>
    <td>allow icmp</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['firewall']['ubuntu_iptables']</tt></td>
    <td>Boolean</td>
    <td>ubuntu iptables</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['firewall']['allow_established']</tt></td>
    <td>Boolean</td>
    <td>allow established</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['firewall']['ipv6_enabled']</tt></td>
    <td>Boolean</td>
    <td>ipv6_enabled</td>
    <td><tt>true</tt></td>
  </tr>
  </table>

###### weave

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['kubernetes']['weave']['version']</tt></td>
    <td>String</td>
    <td>version</td>
    <td><tt>2.5.1</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['weave']['interface']</tt></td>
    <td>String</td>
    <td>interfave</td>
    <td><tt>weave</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['weave']['use_scope']</tt></td>
    <td>Boolean</td>
    <td>use_scope</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['weave']['use_portmap']</tt></td>
    <td>Boolean</td>
    <td>use_portmap</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['weave'][no_masq_local]</tt></td>
    <td>Boolean</td>
    <td>preserve the client source IP address when accessing Services</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['weave']['update_strategy']['type']</tt></td>
    <td>String</td>
    <td>update_strategy</td>
    <td><tt>RollingUpdate</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['weavescope']['version']</tt></td>
    <td>String</td>
    <td>weavespoce version</td>
    <td><tt>0.17.1</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['weavescope']['port']</tt></td>
    <td>String</td>
    <td>weavescope port</td>
    <td><tt>4040</tt></td>
  </tr>
</table>

###### k8s_apiserver

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['bind_address']</tt></td>
    <td>String</td>
    <td>bind_address</td>
    <td><tt>0.0.0.0</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['insecure_bind_address']</tt></td>
    <td>String</td>
    <td>insecure_bind_address</td>
    <td><tt>127.0.0.1</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['insecure_port']</tt></td>
    <td>Integer</td>
    <td>insecure_port</td>
    <td><tt>8080</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['secure_port']</tt></td>
    <td>Integer</td>
    <td>secure_port</td>
    <td><tt>8443</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['service_cluster_ip_range']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>10.222.0.0/16</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['storage_backend']</tt></td>
    <td>String</td>
    <td>storage_backend</td>
    <td><tt>etcd3</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['storage_media_type']</tt></td>
    <td>String</td>
    <td>storage_media_type</td>
    <td><tt>application/vnd.kubernetes.protobuf</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['kubelet_https']</tt></td>
    <td>Boolean</td>
    <td>kubelet_https</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['kubelet_certificate_authority']</tt></td>
    <td>String</td>
    <td>kubelet_certificate_authority</td>
    <td><tt>/etc/kubernetes/ssl/ca.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api'][encryption_provider_config']</tt></td>
    <td>String</td>
    <td>The file containing configuration for encryption providers to be used for storing secrets in etcd</td>
    <td><tt>/etc/kubernetes/encryption-config.yaml</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['kubelet_client_certificate']</tt></td>
    <td>String</td>
    <td>kubelet_client_certificate</td>
    <td><tt>/etc/kubernetes/ssl/apiserver.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['kubelet_client_key']</tt></td>
    <td>String</td>
    <td>kubelet_client_key</td>
    <td><tt>/etc/kubernetes/ssl/apiserver-key.pem</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['kubelet_preferred_address_types']</tt></td>
    <td>String</td>
    <td>List of the preferred NodeAddressTypes to use for kubelet connections.</td>
    <td><tt>InternalIP,ExternalIP,InternalDNS,ExternalDNS,Hostname</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['endpoint_reconciler_type']</tt></td>
    <td>String</td>
    <td>endpoint_reconciler_type</td>
    <td><tt>lease</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['etcd_certfile']</tt></td>
    <td>String</td>
    <td>etcd_certfile</td>
    <td><tt>node['etcd']['cert_file']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['etcd_keyfile']</tt></td>
    <td>String</td>
    <td>etcd_keyfile</td>
    <td><tt>node['etcd']['key_file']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['etcd_cafile']</tt></td>
    <td>String</td>
    <td>etcd_cafile</td>
    <td><tt>node['etcd']['trusted_ca_file']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['allow_privileged']</tt></td>
    <td>Boolean</td>
    <td>allow privileged containers</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['authorization_mode']</tt></td>
    <td>String</td>
    <td>authorization_mode</td>
    <td><tt>node['kubernetes']['authorization']['mode']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['enable_bootstrap_token_auth']</tt></td>
    <td></td>
    <td>default nit, because option without params</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['tls_cert_file']</tt></td>
    <td>String</td>
    <td>tls_cert_file</td>
    <td><tt>node['kubernetes']['tls_cert_file']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['tls_private_key_file']</tt></td>
    <td>String</td>
    <td>tls_private_key_file</td>
    <td><tt>node['kubernetes']['tls_private_key_file']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['client_ca_file']</tt></td>
    <td>String</td>
    <td>client_ca_file</td>
    <td><tt>node['kubernetes']['client_ca_file']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['service_account_key_file']</tt></td>
    <td>String</td>
    <td>service_account_key_file</td>
    <td><tt>node['kubernetes']['service_account_key_file']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['log_dir']</tt></td>
    <td>String</td>
    <td>log_dir</td>
    <td><tt>/var/log/kubernetes</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['feature_gates']</tt></td>
    <td>String</td>
    <td>feature_gates</td>
    <td><tt>node['kubernetes']['feature_gates']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['api']['enable_admission_plugins']</tt></td>
    <td>String</td>
    <td>plugins separated by comma</td>
    <td><tt>DefaultStorageClass, DefaultTolerationSeconds, LimitRanger, MutatingAdmissionWebhook, NamespaceLifecycle, NodeRestriction, PersistentVolumeClaimResize, Priority, ResourceQuota, ServiceAccount, TaintNodesByCondition, ValidatingAdmissionWebhook</tt></td>
  </tr>
</table>

###### k8s_controller

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['kubernetes']['controller_manager']['secure_port'] </tt></td>
    <td>Fixnum</td>
    <td>The port on which to serve HTTPS with authentication and authorization.If 0, don't serve HTTPS at all.</td>
    <td><tt>10257</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['controller_manager']['leader_elect']</tt></td>
    <td>Boolean</td>
    <td>leader_elect</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['controller_manager']['cluster_cidr']</tt></td>
    <td>String</td>
    <td>cluster cird</td>
    <td><tt>node['kubernetes']['cluster_cidr']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['controller_manager']['cluster_name']</tt></td>
    <td>String</td>
    <td>cluster name</td>
    <td><tt>node['kubernetes']['cluster_name']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['controller_manager']['service_account_private_key_file']</tt></td>
    <td>String</td>
    <td>service_account_key_file</td>
    <td><tt>node['kubernetes']['service_account_key_file']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['controller_manager']['cluster_signing_cert_file']</tt></td>
    <td>String</td>
    <td>cluster_signing_cert_file</td>
    <td><tt>node['kubernetes']['cluster_signing_cert_file']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['controller_manager']['cluster_signing_key_file']</tt></td>
    <td>String</td>
    <td>cluster_signing_key_file</td>
    <td><tt>node['kubernetes']['cluster_signing_key_file']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['controller_manager']['root_ca_file']</tt></td>
    <td>String</td>
    <td>root_ca_file</td>
    <td><tt>node['kubernetes']['client_ca_file']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['controller_manager']['master'] </tt></td>
    <td>String</td>
    <td>master</td>
    <td><tt>http://127.0.0.1:#{node['kubernetes']['api']['insecure_port']}</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['controller_manager']['feature_gates']</tt></td>
    <td>String</td>
    <td>feature_gates</td>
    <td><tt>node['kubernetes']['feature_gates']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['controller_manager']['node_monitor_period']</tt></td>
    <td>String</td>
    <td>node_monitor_period</td>
    <td><tt>2s</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['controller_manager']['node_monitor_grace_period']</tt></td>
    <td>String</td>
    <td>node_monitor_grace_period</td>
    <td><tt>16s</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['controller_manager']['pod_eviction_timeout']  </tt></td>
    <td>String</td>
    <td>pod_eviction_timeout</td>
    <td><tt>30s</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['controller_manager']['horizontal_pod_autoscaler_sync_period']</tt></td>
    <td>String</td>
    <td>The period for syncing the number of pods in horizontal pod autoscaler</td>
    <td><tt>30s</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['controller_manager']['horizontal_pod_autoscaler_tolerance']</tt></td>
    <td>Float</td>
    <td>The minimum change (from 1.0) in the desired-to-actual metrics ratio for the horizontal pod autoscaler to consider scaling</td>
    <td><tt>0.1</tt></td>
  </tr>
</table>

###### k8s_proxy
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['kubernetes']['proxy']['kubeconfig']</tt></td>
    <td>String</td>
    <td>path to config</td>
    <td><tt>/etc/kubernetes/system:kube-proxy_config.yaml</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['proxy']['feature_gates']</tt></td>
    <td>Hash</td>
    <td>hash of feature gates</td>
    <td><tt>node['kubernetes']['feature_gates']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['proxy']['global']['metrics_port']</tt></td>
    <td>Fixnum</td>
    <td>The port to bind the metrics server. Use 0 to disable</td>
    <td><tt>10249</tt></td>
  </tr>
</table>

###### scheduler
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['kubernetes']['scheduler']['secure_port'] </tt></td>
    <td>Fixnum</td>
    <td>The port on which to serve HTTPS with authentication and authorization.If 0, don't serve HTTPS at all.</td>
    <td><tt>10259</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['scheduler']['leader_elect'] </tt></td>
    <td>Boolean</td>
    <td>leader_elect</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['scheduler']['feature_gates']</tt></td>
    <td>String</td>
    <td>feature_gates</td>
    <td><tt>node['kubernetes']['feature_gates']</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['scheduler']['master']</tt></td>
    <td>String</td>
    <td>master</td>
    <td><tt>http://127.0.0.1:#{node['kubernetes']['api']['insecure_port']}</tt></td>
  </tr>
</table>


## Usage

### Certificates

Create ssl certificates for k8s.

```
cd ./lib/tasks/ssl
cp config_example.yaml config.yaml
bundler
rake ca:generate
rake apiserver:generate
```

All keys will be generated at `./ssl` folder.

After cluster installation weave pods can contain error about:
```
FATA: 2018/03/15 19:51:39.168435 [kube-peers] Could not get peers: Get https://192.168.128.1:443/api/v1/nodes:
x509: certificate is valid for 127.0.0.1, 10.222.0.1, not 192.168.128.1

```

Add `192.168.128.1` to `ssl/tasks/config.yaml` and recreate and upload new `apiserver-key.pem` and `apiserver.pem`

### Prepare your data_bag

You need to create `kubernetes` data_bag in chef server.

Then add next files:
* apiserver_ssl
* ca_ssl
* encryption_keys
* users

###### Structure:
`apiserver_ssl`
```JSON
{
  "id": "apiserver_ssl",
  "private_key": "PUT apiserver-key.pem HERE",
  "public_key": "PUT apiserver.pem HERE"
}
```

`ca_ssl`
```JSON
{
  "id": "ca_ssl",
  "private_key": "PUT ca-key.pem HERE",
  "public_key": "PUT ca.pem HERE"
}
```

`encryption_keys`
```JSON
{
  "id": "encryption_keys",
  "aescbc": [
    {
      "name": "key1",
      "secret": "baiBu8ais4bu3uRohqu6och5yai4wai8"
    }
  ]
}
```

`users`
```JSON
{
  "id": "users",
  "users": [
    {
      "name": "exampleuser",
      "token": "aenup6io4ciath7yaxu0vie6guaSie6goi3ahri0eemui3Ieghu4tuhaa3kisohv",
      "uid": "10001",
      "groups": [
        "admins"
      ]
    },
    {
      "name": "kubelet-bootstrap",
      "token": "nieJi3ooGh1ohy8sheowee7ohghei3Xaebeeve8Ooch3omex4cho2xuexuuzeeva",
      "uid": "10100",
      "groups": [
        "system:bootstrappers"
      ]
    },
    {
      "name": "kubelet",
      "token": "ieT5Oogecah6geengaeyai3ohNg6Fiecha6iemaifithah2ui3oChaixeThi5Shi",
      "uid": "10101",
      "groups": [
        "kubelet",
        "system:nodes"
      ]
    },
    {
      "name": "system:kube-proxy",
      "token": "ka2thaijaek0oophoothahbahyaiphe6ahteegieyae8il9XohveeJahn3Aizohy",
      "uid": "10102",
      "groups": [
        "system:node-proxier"
      ]
    },
    {
      "name": "scheduler",
      "token": "MoN7ohz2Aebeep2eeneGhie5Hikop9iroSahyezohchuthi8Iu1iVaetae5xaj3W",
      "uid": "10103",
      "groups": [
        "scheduler"
      ]
    }
  ]
}
```

### kubernetes::etcd

Run `kubernetes::etcd` recipe or role on your nodes. Run it twice for normal `chef search`.

Or you can add role without `kubernetes::etcd` for first servers registration in chef.

```
name 'etcd'
description 'Etcd cluster node'
override_attributes(
  'etcd' => {
    initial_cluster_state: 'new',
    initial_cluster_token: 'etcd-test-cluster',
    wal_dir: '/var/lib/etcd/member/wal'
  }
)
run_list 'recipe[kubernetes::etcd]'
```


### kubernetes::master

Include `kubernetes::master` in your master node's `run_list`:

```json
{
  "run_list": [
    "recipe[kubernetes::master]"
  ]
}
```

Or role:
```
name 'kubernetes_master'
description 'Kubernetes master node'
run_list 'recipe[kubernetes::master]'
override_attributes(
  docker: {
    build_in_enable: false
  },
  kubernetes: {
    cluster_name: 'evilms',
    cluster_dns: ['192.168.222.222'],
    cluster_cidr: '192.168.0.0/17',
    api: {
      'service_cluster_ip_range' => '192.168.128.0/17'
    },
    dns: { deploy_via: 'deployment' },
    token_auth: true,
    addons: {
      kubedns: {
        node_selector: 'evl.ms/role=system'
      },
      coredns: {
        node_selector: 'evl.ms/role=system',
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
```

If you use master nodes without minions on them add `kubernetes::packages` to you run_list.

And add master node to role `kube_master`.
This is **obligatory** in multinode configuration - minions uses role to find master.

### kubernetes::default

Include `kubernetes::default` in your minion node's `run_list`:

```json
{
  "run_list": [
    "recipe[kubernetes]"
  ]
}
```

Or role:
```
name 'kubernetes_node'
description 'kubernetes node'
#run_list 'recipe[kubernetes]'
run_list 'recipe[kubernetes]'
override_attributes(
  kubernetes: {
    cluster_name: 'evilms',
    cluster_dns: ['192.168.222.222'],
    token_auth: true,
    api:   { 'service_cluster_ip_range' => '192.168.128.0/17' },
    weave: {
      network: '192.168.0.0/17',
      use_scope: false
    }
  }
)
```

If you use custom docker installation you can disable built-in docker installation
```
docker: {
  'built-in' => false
}
```
Also you can use [CRIO](http://cri-o.io/) as a container runtime interface:
```
kubernetes: {
  'container_runtime': 'crio'
}
```
Don't forget to run ```docker rm -f `docker ps -aq` ``` after successful CRIO installation.

### Dashboard
Starting from release 1.11.0 we are no more ships [kubernetes-dashboard](https://github.com/kubernetes/dashboard/) with cookbook. From now on we recommends to use [helm](https://github.com/kubernetes/helm) and install [kubernetes-dashboard](https://github.com/kubernetes/dashboard/) from [official chart](https://github.com/kubernetes/charts/tree/master/stable/kubernetes-dashboard).

## License and Authors

License:: http://bregor.mit-license.org

Author:: Maxim Filatov (<bregor@evilmartians.com>)
