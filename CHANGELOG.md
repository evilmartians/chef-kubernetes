# UNRELEASED
- make dns bionic compatible
- docker: remove ancient jpetazzo/nsenter
- [CNI/plugins: 0.8.0](https://github.com/containernetworking/plugins/releases/tag/v0.8.0)

# 1.14.1 (17.04.2019)
- [Kubernetes: 1.14.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.14.md#changelog-since-v1140)
- [Docker CE: 18.09.5](https://docs.docker.com/engine/release-notes/#18095)
- [CoreDNS: 1.5.0](https://coredns.io/2019/04/06/coredns-1.5.0-release/)
- [buildah: 1.7.3](https://github.com/containers/buildah/releases/tag/v1.7.3)
- [cri-o: 1.13.4](https://github.com/kubernetes-sigs/cri-o/releases/tag/v1.13.4)
- [podman: 1.2.0](https://github.com/containers/libpod/releases/tag/v1.2.0)
- [skopeo: 0.1.35](https://github.com/containers/skopeo/releases/tag/v0.1.35)
- [runc: 1.0-rc7](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc7)

# 1.14.0
- [Kubernetes: 1.14.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.14.md#kubernetes-v114-release-notes)
- [Docker CE: 18.09.3](https://docs.docker.com/engine/release-notes/#18093)

# 1.13.5 (25.03.2019)
- [podman: 1.1.1](https://github.com/containers/libpod/releases/tag/v1.1.1)
- [CoreDNS: 1.4.0](https://coredns.io/2019/03/03/coredns-1.4.0-release/)
- CoreDNS: change deprecated [proxy](https://coredns.io/plugins/proxy/) plugin to [forward](https://coredns.io/plugins/forward/)
- ApiServer <=> Kubelet communications: `--kubelet-preferred-address-types` apiserver key now explicitly points to `InternalIP,ExternalIP,InternalDNS,ExternalDNS,Hostname`; this way you are free to use hostname (or any other name) for your kubelets, just make sure your kubelet has proper NodeAddressType: `InternalIP` or `ExternalIP` and so on.
  You can check it like this: `$ kubectl get no <node> -o jsonpath='{.status.addresses[?(@.type=="InternalIP")].address}'`
- [CNI/plugins: 0.7.5](https://github.com/containernetworking/plugins/releases/tag/v0.7.5)
- [Kubernetes: 1.13.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.13.md#changelog-since-v1134)

# 1.13.4 (01.03.2019)
- [Docker CE: 18.06.2](https://github.com/docker/docker-ce/releases/tag/v18.06.2-ce) Fixing [CVE-2019-5736](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5736)
- Recipes::Docker: set default action for package `docker-ce` to `:upgrade`
- [Kubernetes: 1.13.4](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.13.md#changelog-since-v1133)
- Kube-proxy: add `metrics-port` and `metrics-bind-address` to cmd flags
- [cri-o: 1.13.1](https://github.com/kubernetes-sigs/cri-o/releases/tag/v1.13.1)
- [buildah: 1.7.1](https://github.com/containers/buildah/releases/tag/v1.7.1)
- [Etcd: 3.3.12](https://github.com/etcd-io/etcd/releases/tag/v3.3.12)

# 1.13.3 (02.02.2019)
- [Weave Net: 2.5.1](https://github.com/weaveworks/weave/releases/tag/v2.5.1)
- [CoreDNS: 1.3.1](https://coredns.io/2019/01/13/coredns-1.3.1-release/)
- [buildah: 1.6](https://github.com/containers/buildah/releases/tag/v1.6)
- [Addon manager: 9.0](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/addon-manager/CHANGELOG.md#version-90--wed-january-16-2019-jordan-liggitt-liggittgooglecom)
- Gemfile.lock: fix [CVE-2018-14404](https://nvd.nist.gov/vuln/detail/CVE-2018-14404)
- [Haproxy: 1.9](https://www.haproxy.com/blog/haproxy-1-9-has-arrived/)
- [Kubernetes: 1.13.3](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.13.md#changelog-since-v1132)
- WIP: [Audit webhook](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#webhook-backend) initial implementation


# 1.13.2 (11.01.2019)
- [runc: 1.0.0-rc6](https://github.com/opencontainers/runc/releases/tag/v1.0.0-rc6)
- runsc: 2018-12-14
- [skopeo: 0.1.34](https://github.com/containers/skopeo/releases/tag/v0.1.34)
- [podman: 1.0.0](https://github.com/containers/libpod/releases/tag/v1.0.0)
- [CoreDNS: 1.3.0](https://coredns.io/2018/12/15/coredns-1.3.0-release/)
- [Etcd: 3.3.11](https://github.com/etcd-io/etcd/releases/tag/v3.3.11)
- [Kubernetes: 1.13.2](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.13.md#changelog-since-v1131)

# 1.13.1 (13.12.2018)
- fix file modes arguments and some more minor syntax issues
- kubelet: fixed warning "failed to get imageFs info: no imagefs label for configured runtime"
- docker version set to 18.06 accordingly to [external dependencies](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.12.md#external-dependencies)
- [Kubernetes: 1.13.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.13.md#changelog-since-v1130)

# 1.13.0 (07.12.2018)
- Apiserver: encryption provider config is no more experimental
- Scheduler: listen on secure port cluster-wide
- Controller manager: listen on secure port cluster-wide
- Apiserver: etcd2 support removed, so no more remark about application/json media type
- [Kubernetes: 1.13.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.13.md/#kubernetes-113-release-notes)
- CoreDNS: security context
- CoreDNS: added plugins: loop, reload, loadbalance
- FeatureGates: added [NodeLease](https://github.com/kubernetes/enhancements/blob/master/keps/sig-node/0009-node-heartbeat.md)
- Controller manager: remove deprecated args
- [podman: 0.12.1](https://github.com/containers/libpod/releases/tag/v0.12.1)
- [cri-o: 1.13.0](https://github.com/kubernetes-incubator/cri-o/releases/tag/v1.13.0)
- FeatureGates: added [TTLAfterFinished](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/#ttl-mechanism-for-finished-jobs)

# 1.12.4 (27.11.2018)
- [Kubernetes: 1.12.3](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.12.md#changelog-since-v1122)
- [cri-o: 1.12.3](https://github.com/kubernetes-incubator/cri-o/releases/tag/v1.12.3)
- [CoreDNS: 1.2.6](https://coredns.io/2018/11/05/coredns-1.2.6-release/)
- [podman: 0.11.1.1](https://github.com/containers/libpod/releases/tag/v0.11.1.1)
- [buildah: 1.5](https://github.com/containers/buildah/releases/tag/v1.5)

# 1.12.3 (20.11.2018)
- Weave: preserve the client source IP address
- Weave: don't mount cni-conf directory when portmap is used
- [Weave Net: 2.5.0](https://github.com/weaveworks/weave/releases/tag/v2.5.0)
- [Addon manager: 8.9](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/addon-manager/CHANGELOG.md#version-89--fri-october-19-2018-jeff-grafton-jgraftongooglecom)
- Apiserver: added [PodNodeSelector](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#podnodeselector) to the list of admission controllers
- [cri-o: 1.12.1](https://github.com/kubernetes-incubator/cri-o/releases/tag/v1.12.1)
- [skopeo: 0.1.32](https://github.com/containers/skopeo/releases/tag/v0.1.32)
- [podman: 0.11.1](https://github.com/containers/libpod/releases/tag/v0.11.1)
- Gemfile.lock: fix [CVE-2018-16471](https://nvd.nist.gov/vuln/detail/CVE-2018-16471) and [CVE-2018-16470](https://nvd.nist.gov/vuln/detail/CVE-2018-16470)


# 1.12.2 (28.10.2018)
- [Kubernetes: 1.12.2](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.12.md#changelog-since-v1121)
- [cri-tools: 1.12.0](https://github.com/kubernetes-sigs/cri-tools/releases/tag/v1.12.0)
- [buildah: 1.4](https://github.com/containers/buildah/releases/tag/v1.4)
- [CoreDNS: 1.2.5](https://coredns.io/2018/10/24/coredns-1.2.5-release/)
- [Etcd: 3.3.10](https://github.com/etcd-io/etcd/releases/tag/v3.3.10)
- [Etcd cookbook: 5.6.0](https://github.com/chef-cookbooks/etcd/blob/master/CHANGELOG.md#560-2018-08-07)
- [podman: 0.10.1.3](https://github.com/containers/libpod/releases/tag/v0.10.1.3)
- [Weave: Morph the livenessProbe into readinessProbe](https://github.com/weaveworks/weave/pull/3421/)
- [cri-o: 1.12.0](https://github.com/kubernetes-incubator/cri-o/releases/tag/v1.12.0)
- [Audit Policy](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#audit-policy) apiVersion set to `v1`
- Gemfile: chef updated to [14.6.47](https://github.com/chef/chef/blob/master/CHANGELOG.md#v14647-2018-10-26)

# 1.12.1 (05.10.2018)
- [Kubernetes: 1.12.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.12.md#changelog-since-v1120)

# 1.12.0 (28.09.2018)
- Reworked API audit options
- Kubelet: [client certificate rotation](https://kubernetes.io/docs/tasks/tls/certificate-rotation) is now enabled by default
- Kubelet: removed `cadvisor_port`
- Feature gates: added [VolumeSubpathEnvExpansion](https://kubernetes.io/docs/concepts/storage/volumes/#using-subpath-with-expanded-environment-variables)
- Apiserver: only etcd3 is available as a storage backend
- Admission plugins: added [Priority](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#priority)
- [Kubernetes: 1.12.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.12.md#changelog-since-v1110)
- [cri-o: 1.11.6](https://github.com/kubernetes-incubator/cri-o/releases/tag/v1.11.6)
- [podman: 0.9.3.1](https://github.com/containers/libpod/releases/tag/v0.9.3.1)

# 1.11.10 (25.09.2018)
- [cri-tools: 1.11.1](https://github.com/kubernetes-sigs/cri-tools/releases/tag/v1.11.1)
- [cri-o: 1.11.5](https://github.com/kubernetes-incubator/cri-o/releases/tag/v1.11.5)
- [podman: 0.9.3](https://github.com/containers/libpod/releases/tag/v0.9.3)
- CoreDNS: Corefile template was update with an option to enable hosts plugin for inline host entries
- Gemfile: update ffi due to [CVE-2018-1000201](https://nvd.nist.gov/vuln/detail/CVE-2018-1000201)

# 1.11.9 (17.09.2018)
- [weave-net: 2.4.1](https://github.com/weaveworks/weave/releases/tag/v2.4.1)
- [podman: 0.9.2](https://github.com/containers/libpod/releases/tag/v0.9.2)
- [cri-o: 1.11.4](https://github.com/kubernetes-incubator/cri-o/releases/tag/v1.11.4)
- Docker: repin daemon version. Fixes https://github.com/evilmartians/chef-kubernetes/issues/14
- Docker: fix for chef >= 13

# 1.11.8 (10.09.2018)
- [podman: 0.9.1](https://github.com/containers/libpod/releases/tag/v0.9.1)
- [CoreDNS: 1.2.2](https://coredns.io/2018/08/29/coredns-1.2.2-release/)
- [Kubernetes: 1.11.3](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.11.md#changelog-since-v1112)

# 1.11.7 (19.08.2018)
- ApiServer: added `--requestheader-client-ca-file` cmdline flag
- ControllerManager: explicit HPA settings
- New addon: [node problem detector](https://github.com/kubernetes/node-problem-detector)
  Disabled by default, use `node['kubernetes']['addons']['npd']['enabled']` to activate
- [Kubernetes: 1.11.2](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.11.md#changelog-since-v1111)
- [cri-o: 1.11.2](https://github.com/kubernetes-incubator/cri-o/releases/tag/v1.11.2)
- [buildah: 1.3](https://github.com/projectatomic/buildah/releases/tag/v1.3)
- [podman: 0.8.3](https://github.com/containers/libpod/releases/tag/v0.8.3)
- [skopeo: 0.1.31](https://github.com/containers/skopeo/releases/tag/v0.1.31)

# 1.11.6 (26.07.2018)
- Etcd: 3.3.9
- Weave: 2.4.0

# 1.11.5 (19.07.2018)
- podman upgraded to 0.7.2
- Kubernetes: 1.11.1
- Etcd systemd unit default name set to `etcd` instead of `etcd-#{node['name']}`

# 1.11.4 (13.07.2018)
- CoreDNS: 1.2.0
- kube-proxy: explicitly set cluster-cidr
- kube-proxy: simplify proxy-mode configuration
- Make kubernetes services network route ipvs compatible
- Packages: install `ipvsadm` and `ipset` for IPVS proxy mode
- kube-proxy: split attributes to global and ipvs-related
- sdn canal: calico updated to 3.1

# 1.11.3 (11.07.2018)
- CNI plugins: bump to 0.7.1
- podman: 0.7.1
- cri-o: 1.11.1

# 1.11.2 (07.07.2018)
- Kubelet: add ability to use custom runtimes
- `kubeletconfig`: check for `RotateKubeletServerCertificate` feature gate before enabling server certificates autorotation
- Docker moved to separate recipe
- install CRIO and corresponding binaries
- Buildah installation recipe
- Explicitly install aufs-tools if cri-o uses aufs as storage
- `kubeletconfig`: explicitly set cgroup driver

# 1.11.1 (28.06.2018)
- Kubernetes: 1.11.0
- Feature gates: remove already enabled by default `MountPropagation` and `VolumeScheduling`
- `recipes/proxy`: typo fix in `LimitNOFILE` systemd-unit instruction
- `kubeletconfig`: fix unexpected camelcase in keys
- `kubeletconfig`: explicitly add TLS-settings

# 1.11.0 (27.06.2018)
- Delete kubernetes dashboard from cookbook
- Kubernetes: 1.11.0-rc.3
- KubeDNS: 1.14.10
- Get rid of upstart (and ubuntu-trusty) support

# 1.10.6 (21.06.2018)
- Return `create` action for etcd recipe
- Add checksum validation for etcd tarball

# 1.10.5 (21.06.2018)
- Kubernetes updated to 1.10.5

# 1.10.4 (21.06.2018)
- [breaking] Upgrade docker from `docker-engine-1.12` to `docker-ce-17.03`
- Etcd updated to 3.3.8

# 1.10.3 (20.06.2018)
- CoreDNS update to [1.1.4](https://github.com/coredns/coredns/releases/tag/v1.1.4)

# 1.10.2 (13.06.2018)
- Add ReadOnlyPort for kubelet. Need for heapster auth.

# 1.10.1 (06.06.2018)
- Etcd updated to [3.3.7](https://github.com/coreos/etcd/blob/master/CHANGELOG-3.3.md#v337-2018-06-06)
- Kubernetes updated to [1.10.4](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.10.md#changelog-since-v1103)

# 1.10.0 (31.05.2018)
- Update versioning procedure. From now on major and minor parts coincedes with Kubernetes major and minor, and patch version reflects the current release number
- Kubernetes updated to 1.10.3
- CoreDNS updated to 1.1.3
- Etcd updated to 3.3.5

# 0.1.3 (15.04.2018)
- Upgrade etcd cookbook dependency from 4.1 to 5.5
- Add chef-client 14 support

# 0.1.2 (14.04.2018)
- Weave: 2.3.0
- Weave: split `--status-addr` into separate `--status-addr` and `--metrics-addr` args
- Weave: make status port and metrics port as attributes
- Etcd: 3.3.3

# 0.1.1 (14.04.2018)
- Kubernetes 1.10.1

# 0.1.0 (05.04.2018)
- Use --config for kubelet
- Change featureGates struct from string to hash
- Update helpers.rb for backward compatibility with service options
- Reanimate inspec with testkitchen.
- Fix docker built-in variables into recipe
- Move kube-proxy config args from recipe to k8s_proxy.rb
- Add sort for master nodes in haproxy config
- Bump cniVersion from 0.3.0 to 0.3.1
- Add haproxy reload by default

# 0.0.4 (03.04.2018)
- Bump to 1.10.0 kubernetes version
- Change packages array to hash
- Move cni plugins symlinks to attributes for enable/disable actions
- Move kubelet args to attributes/kubelet.rb from recipe
- Move apiserver args to attributes/k8s_apiserver.rb from recipe
- Move scheduler args to attributes/scheduler.rb from recipe
- Move controller_manager args to attributes/k8s_controller.rb from recipe

# 0.0.3 (11.03.2018)
- Add custom docker installation. Default `true`. But if you have another docker
  installation you can skip built-in.
- Move packages array from `packages.rb` to default attrs file
- Update README.md for new users.

# 0.0.2 (29.06.2016)

- Bunch of runit services replaced by manifests
- Kubernetes updated to 1.2.5
- Node down detection moved from a 5m40s to 46s (via https://fatalfailure.wordpress.com/2016/06/10/improving-kubernetes-reliability-quicker-detection-of-a-node-down/)
- Weave scope to visualize container network

# 0.0.1

Initial release of kubernetes
