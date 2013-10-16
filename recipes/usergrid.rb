#
# Cookbook Name:: usergridbox
# Recipe:: usergrid
#

execute "clone usergrid-stack" do
  command "git clone git@github.com:apigee/usergrid-stack.git"
end

execute "build usergrid-stack" do
  command "cd usergrid-stack; mvn clean install -DskipTests=true"
end

execute "start usergrid" do
  command "cd usergrid-stack/launcher; java -jar target/usergrid-launcher-*.jar"
end