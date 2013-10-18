#
# Cookbook Name:: usergridbox
# Recipe:: usergrid
#

git "#{Chef::Config[:file_cache_path]}/usergrid" do
  repository "git://github.com/apigee/usergrid-stack.git"
  reference "master"
  action :checkout
end

execute "build usergrid-stack" do
  cwd "#{Chef::Config[:file_cache_path]}/usergrid"
  command "mvn clean install -DskipTests=true -e"
end

git "#{Chef::Config[:file_cache_path]}/usergrid-rest-apigee-sample" do
  repository "git://github.com/zznate/usergrid-rest-apigee-sample.git"
  reference "master"
  action :checkout
end

execute "build usergrid-rest-apigee-sample" do
  cwd "#{Chef::Config[:file_cache_path]}/usergrid-rest-apigee-sample"
  command "mvn install"
end


execute "start usergrid" do
  cwd "#{Chef::Config[:file_cache_path]}/usergrid/launcher"
  command "java -jar target/usergrid-launcher-*.jar"
end