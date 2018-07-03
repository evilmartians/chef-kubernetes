default['kubernetes']['runc']['version']      = '1.0.0-rc5'
default['kubernetes']['runc']['checksum']     = 'eaa9c9518cc4b041eea83d8ef83aad0a347af913c65337abe5b94b636183a251'
default['kubernetes']['runc']['storage_url']  = "https://github.com/opencontainers/runc/releases/download/v%{version}/runc.amd64"
default['kubernetes']['runsc']['version']     = '2018-07-04'
default['kubernetes']['runsc']['storage_url'] = 'https://storage.googleapis.com/gvisor/releases/nightly/%{version}/runsc'
default['kubernetes']['runsc']['checksum']    = '830aefdbe4304a98acbc3293af8e79935ea627c5c267f1f2284bfb1684a8d552'
