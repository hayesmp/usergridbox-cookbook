#
# Cookbook Name:: usergridbox
# Recipe:: usergrid
#

git "#{Chef::Config[:file_cache_path]}" do
  repository "git://github.com:apigee/usergrid-stack.git"
  reference "master"
  action :checkout
end

bash "build usergrid" do
  cwd "#{Chef::Config[:file_cache_path]}/usergrid-stack"
  #user "rbenv"
  #group "rbenv"
  code <<-EOH
     mvn clean install -DskipTests=true
  EOH
  environment 'PREFIX' => "/usr/local"
end


#execute "clone usergrid-stack" do
#  command "git clone git@github.com:apigee/usergrid-stack.git"
#end

#execute "build usergrid-stack" do
#  command "cd usergrid-stack; mvn clean install -DskipTests=true"
#end

execute "start usergrid" do
  command "cd #{Chef::Config[:file_cache_path]}/usergrid-stack/launcher; java -jar target/usergrid-launcher-*.jar"
end