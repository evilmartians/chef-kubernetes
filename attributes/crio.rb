default['kubernetes']['crio']['version']                     = '1.13.0'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = ''
default['kubernetes']['buildah']['version']                  = '1.5'
default['kubernetes']['libpod']['version']                   = '0.12.1'
default['kubernetes']['skopeo']['version']                   = '0.1.32'

default['kubernetes']['checksums']['skopeo']['bionic']       = 'f75adb08b56b01b0096d0734271d732b92819885470321a7fc6dc0e16d4443e0'
default['kubernetes']['checksums']['podman']['bionic']       = 'de1a7417ed233f2949a3f9a88d2f7ed0637e355adb96aa9a2d0f819fef2fa47a'
default['kubernetes']['checksums']['conmon']['bionic']       = '7d9d7acb864ea52ebe2e2936e4ac1fd9388d69abd9e0545bbfbad0be0560fc53'
default['kubernetes']['checksums']['crio']['bionic']         = 'd0d42e9eb5629b9c406b391874f4b300fbf5950de5cf2c7c98e0e2a6266c41c4'
default['kubernetes']['checksums']['buildah']['bionic']      = '5bfe90f4363e0f6ccb30030fcd4f3332f6591d9fd2d35066905d561a7089217e'

default['kubernetes']['checksums']['skopeo']['xenial']       = 'b4d85d321bbbe47dc95d613d37b9b0ee226e60d1af48d6e70fa6dd9ef517f830'
default['kubernetes']['checksums']['podman']['xenial']       = '678976f775040b13dc4915872313d99c2fb11e8fa118812fabff13cca307cec7'
default['kubernetes']['checksums']['conmon']['xenial']       = '8e3814e53cd9e1bc714ed9b50f04f69c18c3d16e3ccaf58b63c61d27af657d33'
default['kubernetes']['checksums']['crio']['xenial']         = '04274ae7d12285eaae5b40b53bddc50cdc99191f4d146623554a739e5b4209ca'
default['kubernetes']['checksums']['buildah']['xenial']      = '6201c7e75d24489363b88d1132539e2fd3b2bb7f0b93b19770e12d7d19bcfde8'

default['kubernetes']['crio']['config']['conmon']            = '/usr/local/bin/conmon'
default['kubernetes']['crio']['config']['storage_driver']    = 'overlay'
default['kubernetes']['crio']['config']['stream_port']       = 10010
default['kubernetes']['crio']['config']['runroot']           = '/var/run/containers/storage'
default['kubernetes']['crio']['config']['root']              = '/var/lib/containers/storage'
default['kubernetes']['crio']['config']['log_level']         = 'info'
default['kubernetes']['crio']['config']['file_locking']      = false
default['kubernetes']['crio']['config']['file_locking_path'] = '/run/crio.lock'
default['kubernetes']['crio']['config']['cgroup_manager']    = 'cgroupfs'
default['kubernetes']['crio']['config']['apparmor_profile']  = 'crio-default'
default['kubernetes']['crio']['config']['seccomp_profile']   = '/etc/crio/seccomp.json'
default['kubernetes']['crio']['config']['pids_limit']        = 1024

default['kubernetes']['crio']['config']['runtimes'] = {
  'trusted'   => '/usr/local/bin/runc',
  'untrusted' => '/usr/local/bin/runsc'
}

default['kubernetes']['crio']['config']['runtimes']['untrusted']       = '/usr/local/bin/runsc'
default['kubernetes']['crio']['config']['container_exits_dir']         = '/var/run/crio/exits'
default['kubernetes']['crio']['config']['container_attach_socket_dir'] = '/var/run/crio'

default['kubernetes']['crio']['daemon_flags']['log_format']     = 'text'
default['kubernetes']['crio']['daemon_flags']['profile']        = false
default['kubernetes']['crio']['daemon_flags']['enable_metrics'] = true
default['kubernetes']['crio']['daemon_flags']['metrics_port']   = 9090

default['kubernetes']['crio']['policies']['default'] = [{"type"=>"insecureAcceptAnything"}]
default['kubernetes']['crio']['policies']['transports']['docker-daemon'][''] = [{"type"=>"insecureAcceptAnything"}]

default['kubernetes']['crio']['crictl']['version'] = '1.12.0'
default['kubernetes']['crio']['crictl']['timeout'] = 10
default['kubernetes']['crio']['crictl']['debug']   = false

default['kubernetes']['limits']['nofile']['crio'] = 1048576
default['kubernetes']['limits']['nproc']['crio']  = 1048576
default['kubernetes']['limits']['core']['crio']   = 'infinity'
