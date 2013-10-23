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

#rm -rf /var/lib/tomcat6/webapps/ROOT
file "/var/lib/tomcat6/webapps/ROOT" do
  owner "root"
  group "root"
  #mode "0755"
  action :delete
end

#cp /var/chef/cache/usergrid/rest/target/ROOT.war /var/lib/tomcat6/webapps/
execute "copy usergrid war into tomcat" do
  command "cp /var/chef/cache/usergrid/rest/target/ROOT.war /var/lib/tomcat6/webapps/"
end

#Edit /var/chef/cache/usergrid/config/src/main/resources/usergrid-default.properties
  #cassandra.url=localhost:9160
  #cassandra.username=
  #cassandra.password=

  ## SysAdmin login
  #usergrid.sysadmin.login.name=
  #usergrid.sysadmin.login.email=
  #usergrid.sysadmin.login.password=
  #usergrid.sysadmin.login.allowed=false

  #Go to <ip address>:8080/setup