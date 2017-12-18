%w(
  sa
  clusterrole
  clusterrolebinding
  role
  rolebinding
  daemonset
).each do |addon|
  describe file("/etc/kubernetes/addons/weave-kube-#{addon}.yaml") do
    it { should exist }
    it { should be_file }
  end
end

describe file('/etc/cni/net.d/10-weave.conflist') do
  it { should exist }
  it { should be_file }
end

describe file('/etc/kubernetes/addons') do
  it { should exist }
  it { should be_directory }
end

%w(
  sa
  clusterrole
  clusterrolebinding
  role
  rolebinding
  daemonset
).each do |addon|
  describe file("/etc/kubernetes/addons/weave-kube-#{addon}.yaml") do
    it { should exist }
    it { should be_file }
  end
end
