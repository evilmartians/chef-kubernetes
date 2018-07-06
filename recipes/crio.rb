#
# Cookbook Name:: kubernetes
# Recipe:: crio
#
# Author:: Maxim Filatov <bregor@evilmartians.com>
#

include_recipe 'kubernetes::runc'

apt_repository 'ostree' do
  uri 'ppa:alexlarsson/flatpak'
  distribution node['lsb']['codename']
end

package 'ostree'
package 'libgpgme11'
package 'seccomp'

crio_version   = node['kubernetes']['crio']['version']
crictl_version = node['kubernetes']['crio']['crictl']['version']
skopeo_version = node['kubernetes']['skopeo']['version']
libpod_version = node['kubernetes']['libpod']['version']

directory("/opt/crio/#{crio_version}") { recursive true }
directory("/opt/crictl/#{crictl_version}") { recursive true }
directory("/opt/libpod/#{libpod_version}") { recursive true }
directory("/opt/skopeo/#{skopeo_version}") { recursive true }

codename = node['lsb']['codename']

remote_file "/opt/crio/#{crio_version}/crio" do
  source "https://s3-eu-west-1.amazonaws.com/crio-binaries/#{codename}/cri-o/v#{crio_version}/crio"
  mode 0755
  checksum node['kubernetes']['checksums']['crio'][codename]
end

remote_file "/opt/crio/#{crio_version}/conmon" do
  source "https://s3-eu-west-1.amazonaws.com/crio-binaries/#{codename}/cri-o/v#{crio_version}/conmon"
  mode 0755
  checksum node['kubernetes']['checksums']['conmon'][codename]
end

remote_file "/opt/skopeo/#{skopeo_version}/skopeo" do
  source "https://s3-eu-west-1.amazonaws.com/crio-binaries/#{codename}/skopeo/v#{skopeo_version}/skopeo"
  mode 0755
  checksum node['kubernetes']['checksums']['skopeo'][codename]
end

remote_file "/opt/libpod/#{libpod_version}/podman" do
  source "https://s3-eu-west-1.amazonaws.com/crio-binaries/#{codename}/libpod/v#{libpod_version}/podman"
  mode 0755
  checksum node['kubernetes']['checksums']['podman'][codename]
end

tar_extract "https://github.com/kubernetes-incubator/cri-tools/releases/download/v#{crictl_version}/crictl-v#{crictl_version}-linux-amd64.tar.gz" do
  creates "/opt/crictl/#{crictl_version}/crictl"
  target_dir "/opt/crictl/#{crictl_version}"
end

link '/usr/local/bin/crio' do
  to "/opt/crio/#{crio_version}/crio"
  notifies :restart, 'systemd_unit[crio.service]'
end

link '/usr/local/bin/conmon' do
  to "/opt/crio/#{crio_version}/conmon"
end

link '/usr/local/bin/crictl' do
  to "/opt/crictl/#{crictl_version}/crictl"
end

link '/usr/local/bin/skopeo' do
  to "/opt/skopeo/#{skopeo_version}/skopeo"
end

link '/usr/local/bin/podman' do
  to "/opt/libpod/#{libpod_version}/podman"
end

directory('/etc/crio') { recursive true }
directory('/var/lib/crio') { recursive true }
directory('/etc/containers/oci/hooks.d') { recursive true }
directory('/usr/share/containers/oci/hooks.d') { recursive true }

file '/etc/containers/policy.json' do
  content node['kubernetes']['crio']['policies'].to_json
end

template '/etc/containers/registries.conf' do
  source 'registries.conf.erb'
end

template '/etc/containers/storage.conf' do
  source 'storage.conf.erb'
end

template '/etc/crio/crio.conf' do
  source 'crio.conf.erb'
  variables(stream_address: k8s_ip(node))
  notifies :restart, 'systemd_unit[crio.service]'
end

template '/etc/crio/seccomp.json' do
  source 'seccomp.json.erb'
  notifies :restart, 'systemd_unit[crio.service]'
end

systemd_unit 'crio.service' do
  content(
    Unit: {
      Description: 'CRI-O daemon',
      Documentation: 'https://github.com/kubernetes-incubator/cri-o',
      After: 'network.target remote-fs.target',
    },
    Service: {
      Type: 'notify',
      Environment: 'GOTRACEBACK=crash',
      ExecStart: "/usr/local/bin/crio #{crio_args.join(" \\\n")}",
      ExecReload: '/bin/kill -HUP $MAINPID',
      TasksMax: 'infinity',
      LimitNOFILE: node['kubernetes']['limits']['nofile']['crio'],
      LimitNPROC: node['kubernetes']['limits']['nproc']['crio'],
      LimitCORE: node['kubernetes']['limits']['core']['crio'],
      OOMScoreAdjust: -999,
      Restart: 'on-abnormal',
      RestartSec: '10s',
      TimeoutStartSec: 0,
    },
    Install: {
      WantedBy: 'multi-user.target',
    }
  )
  notifies :restart, 'systemd_unit[crio.service]'
  action [:create, :enable, :start]
end

# systemd_unit 'crio-shutdown.service' do
#   content(
#     Unit: {
#       Description: 'Shutdown CRIO containers before shutting down the system',
#       Wants: 'crio.service',
#       After: 'crio.service',
#       Documentation: 'man:crio(8)'
#     },

#     Service: {
#       Type: 'oneshot',
#       ExecStart: '/bin/rm -f /var/lib/crio/crio.shutdown',
#       ExecStop: '/bin/bash -c "/usr/bin/touch /var/lib/crio/crio.shutdown"',
#       RemainAfterExit: 'yes'
#     },

#     Install: {
#       WantedBy: 'multi-user.target'
#     }
#   )
#   action [:create, :enable]
# end

template '/etc/crictl.yaml' do
  source 'crictl.yaml.erb'
  variables(
    runtime_endpoint: container_runtime_endpoint,
    image_endpoint: container_runtime_endpoint,
  )
end

firewall_rule 'crio_monitoring' do
  port node['kubernetes']['crio']['daemon_flags']['metrics_port']
  protocol :tcp
  interface node['kubernetes']['interface']
  command :allow
  only_if do
    node['kubernetes']['enable_firewall']
  end
end
