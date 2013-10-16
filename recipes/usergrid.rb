#
# Cookbook Name:: usergridbox
# Recipe:: usergrid
#

git "#{Chef::Config[:file_cache_path]}/usergrid" do
  repository "git://github.com/apigee/usergrid-stack.git"
  reference "master"
  action :checkout
end

#bash "build usergrid" do
#  cwd "#{Chef::Config[:file_cache_path]}/usergrid-stack"
#  #user "rbenv"
#  #group "rbenv"
#  code <<-EOH
#     mvn clean install -DskipTests=true
#  EOH
#  environment 'PREFIX' => "/usr/local"
#end


#execute "clone usergrid-stack" do
#  command "git clone git@github.com:apigee/usergrid-stack.git"
#end

execute "build usergrid-stack" do
  cwd "#{Chef::Config[:file_cache_path]}/usergrid"
  command "mvn clean install -DskipTests=true -e"
end

execute "start usergrid" do
  cwd "#{Chef::Config[:file_cache_path]}/usergrid/launcher"
  command "java -jar target/usergrid-launcher-*.jar"
end