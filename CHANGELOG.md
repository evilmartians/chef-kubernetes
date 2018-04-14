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
