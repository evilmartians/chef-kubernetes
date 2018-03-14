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
    <td><tt>['kubernetes']['etcd']['version']</tt></td>
    <td>String</td>
    <td>version of etcd image</td>
    <td><tt>v2.1.1</tt></td>
  </tr>
</table>

## Usage

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
    cluster_dns: '192.168.222.222',
    cluster_cidr: '192.168.0.0/17',
    api: {
      'service_cluster_ip_range' => '192.168.128.0/17',
      'runtime_config' => %w(batch/v2alpha1)
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
run_list 'recipe[selectel-docker]','recipe[kubernetes]'
override_attributes(
  kubernetes: {
    cluster_name: 'evilms',
    cluster_dns: '192.168.222.222',
    token_auth: true,
    api:   { 'service_cluster_ip_range' => '192.168.128.0/17' },
    weave: {
      network: '192.168.0.0/17',
      use_scope: false
    }
  }
)
```

If you use custom docker installation you can disable built-it docker installation
```
docker: {
  'build-it' => false
}
```

## License and Authors

License:: http://bregor.mit-license.org

Author:: Maxim Filatov (<bregor@evilmartians.com>)
