# UNRELEASED
- [Weave Net: 2.5.0](https://github.com/weaveworks/weave/releases/tag/v2.5.0)
- Gemfile.lock: fix [CVE-2018-16471](https://nvd.nist.gov/vuln/detail/CVE-2018-16471) and [CVE-2018-16470](https://nvd.nist.gov/vuln/detail/CVE-2018-16470)

# 1.11.12 (01.11.2018)
- Weave: preserve the client source IP address
- Weave: don't mount cni-conf directory when portmap is used
- [CoreDNS: 1.2.5](https://coredns.io/2018/10/24/coredns-1.2.5-release/)
- [podman: 0.10.1.3](https://github.com/containers/libpod/releases/tag/v0.10.1.3)
- [Kubernetes: 1.11.4](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.11.md/#changelog-since-v1113)
- [Addon manager: 8.9](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/addon-manager/CHANGELOG.md#version-89--fri-october-19-2018-jeff-grafton-jgraftongooglecom)
- Gemfile: chef updated to [14.6.47](https://github.com/chef/chef/blob/master/CHANGELOG.md#v14647-2018-10-26)


# 1.11.11
- [podman: 0.10.1.1](https://github.com/containers/libpod/releases/tag/v0.10.1.1)
- [buildah: 1.4](https://github.com/containers/buildah/releases/tag/v1.4)
- [CoreDNS: 1.2.4](https://coredns.io/2018/10/16/coredns-1.2.4-release/)
- [Etcd: 3.3.10](https://github.com/etcd-io/etcd/releases/tag/v3.3.10)
- [Etcd cookbook: 5.6.0](https://github.com/chef-cookbooks/etcd/blob/master/CHANGELOG.md#560-2018-08-07)
- [Weave: Morph the livenessProbe into readinessProbe](https://github.com/weaveworks/weave/pull/3421/)
- Reworked API audit options
- [cri-o: 1.11.6](https://github.com/kubernetes-incubator/cri-o/releases/tag/v1.11.6)

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
