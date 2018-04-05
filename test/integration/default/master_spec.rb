%w(
  apiserver
  controller-manager
  scheduler
).each do |component|
  describe file("/opt/kubernetes/v1.10.0/bin/kube-#{component}") do
    it { should exist }
    it { should be_file }
    it { should be_executable }
  end

  describe systemd_service("kube-#{component}") do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

%w(
  apiserver
  apiserver-key
  ca
  ca-key
).each do |key|
  describe file("/etc/kubernetes/ssl/#{key}.pem") do
    it { should exist }
    it { should be_file }
  end
end

%w(
  apiserver-to-kubelet-clusterrole.yaml
  admin-clusterrolebinding.yaml
  node-bootstrapper-clusterrolebinding.yaml
  apiserver-to-kubelet-clusterrolebinding.yaml
  kubelet-client-certificate-rotation-clusterrolebinding.yaml
  kubelet-server-certificate-rotation-clusterrolebinding.yaml
).each do |addon|
  describe file("/etc/kubernetes/addons/#{addon}") do
    it { should exist }
    it { should be_file }
  end
end

%w(
  known_tokens.csv
  system:kube-proxy_config.yaml
  kube-system-ns.yaml
).each do |config|
  describe file("/etc/kubernetes/#{config}") do
    it { should exist }
    it { should be_file }
  end
end
