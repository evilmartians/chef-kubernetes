# kubernetes-cookbook

Google Kubernetes installer for deb-based distros with docker

## Supported Platforms

- Debian
- Ubuntu

### Attributes ###

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['kubernetes']['version']</tt></td>
    <td>String</td>
    <td>version of hyperkube image</td>
    <td><tt>v1.0.3</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['interface']</tt></td>
    <td>String</td>
    <td>Network interface name for use with kubernetes</td>
    <td><tt>eth1</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['etcd']['discovery_url']</tt></td>
    <td>String</td>
    <td>Cluster discovery URL</td>
    <td><tt>''</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['etcd']['version']</tt></td>
    <td>String</td>
    <td>version of etcd image</td>
    <td><tt>v2.1.1</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['flannel']['version']</tt></td>
    <td>String</td>
    <td>version of flannel image</td>
    <td><tt>0.5.2</tt></td>
  </tr>
  <tr>
    <td><tt>['kubernetes']['flannel']['network']</tt></td>
    <td>Hash</td>
    <td>Network range used by flanneld</td>
    <td><tt>{'Network' => '10.222.10.0/16'}</tt></td>
  </tr>
</table>

## Usage

### Discovery url

Be sure to get new discovery url for every new cluster from http://discovery.etcd.io/new?size=XXX (by default cluster size is equal to 3)
and set it to `node['kubernetes']['etcd']['discovery_url']`

### kubernetes::master

Include `kubernetes::master` in your master node's `run_list`:

```json
{
  "run_list": [
    "recipe[kubernetes::master]"
  ]
}
```

And add master node to role `kube_master`.
This is **obligatory** in multinode configuration - minions uses role to find master.

### kubernetes::node

Include `kubernetes::node` in your minion node's `run_list`:

```json
{
  "run_list": [
    "recipe[kubernetes::node]"
  ]
}
```

## License and Authors

License:: http://bregor.mit-license.org

Author:: Maxim Filatov (<bregor@evilmartians.com>)
