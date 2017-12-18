%w(
  0.6.0/cnitool
  0.6.0/noop
  plugins/0.6.0/flannel
  plugins/0.6.0/ptp
  plugins/0.6.0/host-local
  plugins/0.6.0/portmap
  plugins/0.6.0/tuning
  plugins/0.6.0/vlan
  plugins/0.6.0/sample
  plugins/0.6.0/dhcp
  plugins/0.6.0/ipvlan
  plugins/0.6.0/macvlan
  plugins/0.6.0/loopback
  plugins/0.6.0/bridge
).each do |bin_path|
  describe file("/opt/cni/#{bin_path}") do
    it { should exist }
    it { should be_file }
    it { should be_executable }
  end
end
