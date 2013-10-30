#
# Cookbook Name:: usergridbox
# Recipe:: cassandra
#
include_recipe 'apt'
include_recipe 'build-essential'
include_recipe 'java::oracle'
include_recipe 'thrift'
include_recipe 'maven'

td          = Chef::Config[:file_cache_path]
tmp         = File.join(td, "dsc-cassandra-1.1.11-bin.tar.gz")
tarball_dir = File.join(td, "dsc-cassandra-1.1.11-bin")

remote_file(tmp) do
  source "http://downloads.datastax.com/community/dsc-cassandra-1.1.11-bin.tar.gz"

  #not_if "which cassandra"
end

["/var/log/cassandra", "/var/lib/cassandra"].each do |dir|
  directory dir do
    owner     "root"
    group     "root"
    recursive true
    action    :create
  end
end

bash "extract #{tmp}" do
  user "root"
  cwd  "/tmp"

  code <<-EOS
    rm -rf #{tarball_dir}
    tar xfz #{tmp}
  EOS

  creates tarball_dir
end

execute "start cassandra" do
  command "#{Chef::Config[:file_cache_path]}/bin/cassandra"
end
