name 'etcd'
description 'Etcd cluster node'
override_attributes(
  'etcd' => {
    initial_cluster_state: 'new',
    initial_cluster_token: 'etcd-test-cluster',
    wal_dir: '/var/lib/etcd/member/wal',
  }
)
run_list 'recipe[kubernetes::etcd]'
