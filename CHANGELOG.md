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
