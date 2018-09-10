default['kubernetes']['crio']['version']                     = '1.11.2'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = 'unix://'
default['kubernetes']['buildah']['version']                  = '1.3'
default['kubernetes']['libpod']['version']                   = '0.9.1'
default['kubernetes']['skopeo']['version']                   = '0.1.31'

default['kubernetes']['checksums']['skopeo']['bionic']       = 'f6be0f8da43129d7c13b9d69d470ff34ea2e016d1a484fadab2a0219c73797f1'
default['kubernetes']['checksums']['podman']['bionic']       = '410ef7e91bb5d02c9e72e08495d9a1a3f4929aa52ab2769703de9c8ac89e0ad3'
default['kubernetes']['checksums']['conmon']['bionic']       = '8e8bcfa5e7599cba169598fcdb62c05353ddc8a8cca369556bbde590b4593a05'
default['kubernetes']['checksums']['crio']['bionic']         = 'bc3890032f23ae2c897d4f3d434dd2cd8415ca72f0b85126d7b16fd7f279d9ca'
default['kubernetes']['checksums']['buildah']['bionic']      = 'bbd16dee74e1eac148144e33c2880d4321de0a6732456f795255663e9581cbb7'

default['kubernetes']['checksums']['skopeo']['xenial']       = '2f5e480ecb368b41214035aa9882b5f3b1a0a72babff1448ae3f875582a34520'
default['kubernetes']['checksums']['podman']['xenial']       = '1bdc4cd4b2937234ff1f4f8d0381a894c14bf1c958d5928cc0a111d4e91510d7'
default['kubernetes']['checksums']['conmon']['xenial']       = '115a630ec16d8901244c46ef503403ef4512318ce3c4596e3efa1d949b654df9'
default['kubernetes']['checksums']['crio']['xenial']         = 'a2131217dca4f010046434b06e9ff4a9bef175e48405fc81b8629b3dc7c0e634'
default['kubernetes']['checksums']['buildah']['xenial']      = 'f3fe005b3386b4c2f11270425c96f6841f52dbbeb75582ac4b78ce5fb3943ad0'

default['kubernetes']['crio']['config']['runtime']           = '/usr/local/bin/runc'
default['kubernetes']['crio']['config']['untrusted_runtime'] = '/usr/local/bin/runsc'
default['kubernetes']['crio']['config']['conmon']            = '/usr/local/bin/conmon'
default['kubernetes']['crio']['config']['storage_driver']    = 'aufs'
default['kubernetes']['crio']['config']['stream_port']       = 10010
default['kubernetes']['crio']['config']['runroot']           = '/var/run/containers/storage'
default['kubernetes']['crio']['config']['root']              = '/var/lib/containers/storage'

default['kubernetes']['crio']['config']['runtime']           = '/usr/local/bin/runc'
default['kubernetes']['crio']['config']['untrusted_runtime'] = '/usr/local/bin/runsc'
default['kubernetes']['crio']['config']['conmon']            = '/usr/local/bin/conmon'
default['kubernetes']['crio']['config']['storage_driver']    = 'aufs'
default['kubernetes']['crio']['config']['stream_port']       = 10010
default['kubernetes']['crio']['config']['runroot']           = '/var/run/containers/storage'
default['kubernetes']['crio']['config']['root']              = '/var/lib/containers/storage'
default['kubernetes']['crio']['config']['log_level']         = 'info'

default['kubernetes']['crio']['daemon_flags']['log_format']     = 'text'
default['kubernetes']['crio']['daemon_flags']['profile']        = false
default['kubernetes']['crio']['daemon_flags']['enable_metrics'] = true
default['kubernetes']['crio']['daemon_flags']['metrics_port']   = 9090

default['kubernetes']['crio']['policies']['default'] = [{"type"=>"insecureAcceptAnything"}]
default['kubernetes']['crio']['policies']['transports']['docker-daemon'][''] = [{"type"=>"insecureAcceptAnything"}]

default['kubernetes']['crio']['crictl']['version'] = '1.11.0'
default['kubernetes']['crio']['crictl']['timeout'] = 10
default['kubernetes']['crio']['crictl']['debug']   = false

default['kubernetes']['limits']['nofile']['crio'] = 1048576
default['kubernetes']['limits']['nproc']['crio']  = 1048576
default['kubernetes']['limits']['core']['crio']   = 'infinity'
