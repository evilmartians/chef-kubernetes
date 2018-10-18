default['kubernetes']['crio']['version']                     = '1.11.6'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = 'unix://'
default['kubernetes']['buildah']['version']                  = '1.4'
default['kubernetes']['libpod']['version']                   = '0.10.1.3'
default['kubernetes']['skopeo']['version']                   = '0.1.31'

default['kubernetes']['checksums']['skopeo']['bionic']       = 'f6be0f8da43129d7c13b9d69d470ff34ea2e016d1a484fadab2a0219c73797f1'
default['kubernetes']['checksums']['podman']['bionic']       = '4c2ae1942eba3043afed4c24965a2db013f8f476dd73ff47888ed7fa86747ac1'
default['kubernetes']['checksums']['conmon']['bionic']       = '3aa6bb30cbc4d5178f01797c4277ec3a315d8e9809d1a3eb730f2e63ab5ef1fd'
default['kubernetes']['checksums']['crio']['bionic']         = '477861f43be087f9e175e43c8b4fb519e7bd3dceeace77bd5d918b353eac910e'
default['kubernetes']['checksums']['buildah']['bionic']      = 'ea737e861c71bba578b75001a8bf0d60e2cf69f06127deda61c3ad627a4d6bf4'

default['kubernetes']['checksums']['skopeo']['xenial']       = '2f5e480ecb368b41214035aa9882b5f3b1a0a72babff1448ae3f875582a34520'
default['kubernetes']['checksums']['podman']['xenial']       = '2b77b79867b6f148ddf0f3f310c05b724ab1a3c51e2c93d954ddba86aa080c2b'
default['kubernetes']['checksums']['conmon']['xenial']       = '66bb241e610140166cfcbe2175aee7d32073a94ef24977e5890cbd42a1e38009'
default['kubernetes']['checksums']['crio']['xenial']         = 'c011719198925a8348cc989e3f5b885ac008a917a7576ff5256defb8ba46c003'
default['kubernetes']['checksums']['buildah']['xenial']      = '5b1f4b24782447d87c5a2fa21617c4b27e06768170c8e9c8bed3f8181b2ec191'

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

default['kubernetes']['crio']['crictl']['version'] = '1.12.0'
default['kubernetes']['crio']['crictl']['timeout'] = 10
default['kubernetes']['crio']['crictl']['debug']   = false

default['kubernetes']['limits']['nofile']['crio'] = 1048576
default['kubernetes']['limits']['nproc']['crio']  = 1048576
default['kubernetes']['limits']['core']['crio']   = 'infinity'
