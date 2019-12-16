%w(
  plugins/0.8.3/flannel
  plugins/0.8.3/ptp
  plugins/0.8.3/host-local
  plugins/0.8.3/portmap
  plugins/0.8.3/tuning
  plugins/0.8.3/vlan
  plugins/0.8.3/dhcp
  plugins/0.8.3/ipvlan
  plugins/0.8.3/macvlan
  plugins/0.8.3/loopback
  plugins/0.8.3/bridge
).each do |bin_path|
  describe file("/opt/cni/#{bin_path}") do
    it { should exist }
    it { should be_file }
    it { should be_executable }
  end
end
