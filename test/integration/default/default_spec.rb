%w(
  iptables
  ebtables
  socat
  ethtool
  kmod
  tcpd
  dbus
  apt-transport-https
  conntrack
  linux-image-extra-virtual
  docker-ce
).each do |package_name|
  describe package(package_name) do
    it { should be_installed }
  end
end

describe systemd_service('kubelet') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/kubernetes/kubeletconfig.yaml') do
  it { should exist }
  its('size') { should be > 100 }
end

describe command('grep "failed to load Kubelet config file /etc/kubernetes/kubeletconfig.yaml" /var/log/syslog') do
  its('exit_status') { should_not eq 0 }
end

describe command('ip r') do
  its('stdout') { should match(%r{192\.168\.128\.0/17\sdev.*scope\slink}) }
end

describe command('/usr/local/bin/kubectl get csr') do
  its('stdout') { should match(/Approved,Issued/) }
end
