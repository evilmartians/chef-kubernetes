default['kubernetes']['crio']['version']                     = '1.11.4'
default['kubernetes']['crio']['endpoint']                    = '/var/run/crio/crio.sock'
default['kubernetes']['crio']['endpoint_proto']              = 'unix://'
default['kubernetes']['buildah']['version']                  = '1.3'
default['kubernetes']['libpod']['version']                   = '0.9.2'
default['kubernetes']['skopeo']['version']                   = '0.1.31'

default['kubernetes']['checksums']['skopeo']['bionic']       = 'f6be0f8da43129d7c13b9d69d470ff34ea2e016d1a484fadab2a0219c73797f1'
default['kubernetes']['checksums']['podman']['bionic']       = 'b4f1923a5cc457ac205306ab45f63028bd936095c47714dc9bdc19251ba70b5a'
default['kubernetes']['checksums']['conmon']['bionic']       = '92fc3ab88014b157a5671cd0debff340a3499deecfc6e6113ee04bcf849e5cd4'
default['kubernetes']['checksums']['crio']['bionic']         = '55c2b2f014a29278bb70339fdde943d7731d959ff08633af96cb0778d32755f1'
default['kubernetes']['checksums']['buildah']['bionic']      = 'bbd16dee74e1eac148144e33c2880d4321de0a6732456f795255663e9581cbb7'

default['kubernetes']['checksums']['skopeo']['xenial']       = '2f5e480ecb368b41214035aa9882b5f3b1a0a72babff1448ae3f875582a34520'
default['kubernetes']['checksums']['podman']['xenial']       = '8ce7bcd8474ec25dc82d179c20b36d486214ed8ae06534ad94726425d23411a2'
default['kubernetes']['checksums']['conmon']['xenial']       = '4425a9b6c65fdb2b4742cdd6ef23f6e6855a66fc89e5182504b55a15eddc1e0f'
default['kubernetes']['checksums']['crio']['xenial']         = 'b136d06a7a440ea6ff21ceb3bf9e1b3dad2ee73091f0e37e170f6e8bc6132914'
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

default['kubernetes']['crio']['crictl']['version'] = '1.11.1'
default['kubernetes']['crio']['crictl']['timeout'] = 10
default['kubernetes']['crio']['crictl']['debug']   = false

default['kubernetes']['limits']['nofile']['crio'] = 1048576
default['kubernetes']['limits']['nproc']['crio']  = 1048576
default['kubernetes']['limits']['core']['crio']   = 'infinity'
