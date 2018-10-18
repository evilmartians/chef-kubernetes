default['kubernetes']['crio']['version']                     = '1.12.0'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = 'unix://'
default['kubernetes']['buildah']['version']                  = '1.4'
default['kubernetes']['libpod']['version']                   = '0.10.1.3'
default['kubernetes']['skopeo']['version']                   = '0.1.31'

default['kubernetes']['checksums']['skopeo']['bionic']       = 'f6be0f8da43129d7c13b9d69d470ff34ea2e016d1a484fadab2a0219c73797f1'
default['kubernetes']['checksums']['podman']['bionic']       = '4c2ae1942eba3043afed4c24965a2db013f8f476dd73ff47888ed7fa86747ac1'
default['kubernetes']['checksums']['conmon']['bionic']       = 'af0abcd699087c127e35ae143aa728f66a2d99f64ad7fd9fb72f6d24ceefef8f'
default['kubernetes']['checksums']['crio']['bionic']         = 'b571da00b30dc00b9aabdbc9a3e9975d53d29e6089e46c531577c4e1c41532c2'
default['kubernetes']['checksums']['buildah']['bionic']      = 'ea737e861c71bba578b75001a8bf0d60e2cf69f06127deda61c3ad627a4d6bf4'

default['kubernetes']['checksums']['skopeo']['xenial']       = '2f5e480ecb368b41214035aa9882b5f3b1a0a72babff1448ae3f875582a34520'
default['kubernetes']['checksums']['podman']['xenial']       = '2b77b79867b6f148ddf0f3f310c05b724ab1a3c51e2c93d954ddba86aa080c2b'
default['kubernetes']['checksums']['conmon']['xenial']       = '8a5d8dbb09bd2209fde3d5d462ece619a632d934a9cbfa3c55c0c81da1238158'
default['kubernetes']['checksums']['crio']['xenial']         = '65e74a00dc23291facd4635a94355cdb9178596b3acda8aed2e504e3cabb22bd'
default['kubernetes']['checksums']['buildah']['xenial']      = '5b1f4b24782447d87c5a2fa21617c4b27e06768170c8e9c8bed3f8181b2ec191'

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
