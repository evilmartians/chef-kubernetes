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
    <td><tt>['kubernetes']['cluster_name']</tt></td>
    <td>String</td>
    <td>Cluster name to use with API</td>
    <td><tt>kubernetes</tt></td>
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

### Certificates

Create ssl certificates for k8s.

```
cd ./lib/tasks/ssl
cp config_example.yaml config.yaml
bundler
rake ca:default
```

All keys will be generated at `./ssl` folder.

### Prepare your data_bag

You need to create `kubernetes` data_bag in chef server.

Then add next files:
* ca_ssl
* encryption_keys
* users

###### Structure:

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

### kubernetes::default

Include `kubernetes::default` in your minion node's `run_list`:

```json
{
  "run_list": [
    "recipe[kubernetes]"
  ]
}
```

## License and Authors

License:: http://bregor.mit-license.org

Author:: Maxim Filatov (<bregor@evilmartians.com>)
