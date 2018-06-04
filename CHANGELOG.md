# 1.9.3 (04.06.2018)
- Etcd updated to 3.3.6

# 1.9.2 (31.05.2018)
- Kubernetes updated to 1.9.8
- Etcd updated to 3.3.5
- CoreDNS updated to 1.1.3
- WeaveNet updated to 2.3.0
- Haproxy: sort master nodes to prevent config reload on each run
- Haproxy: reload instead of restart

# 1.9.1 (20.04.2018)
- Kubernetes updated to 1.9.7
- Etcd updated to 3.3.3
- KubeDNS updated to 1.14.9

# 1.9.0 (28.03.2018)
- Update versioning procedure. From now on major and minor parts coincedes with Kubernetes major and minor, and patch version reflects the current release number
- Kubernetes updated to 1.9.6
- CoreDNS updated to 1.1.1

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
