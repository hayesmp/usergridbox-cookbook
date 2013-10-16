#
# Cookbook Name:: usergridbox
# Recipe:: usergrid
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#desc "Load and launch"
task :load_and_launch => [:download_built, :launch] do
  puts "Just downloaded a prebuilt usergrid and launched it."
  puts "Maybe http://localhost:8880/?api_url=http://localhost:8080 will work!"
  puts "Usergrid should be at http://localhost:8080/"
  system('cat usergrid-stack/config/src/main/resources/usergrid-default.properties | grep "usergrid.test-account"')
end

#desc "(re)build usergrid."
task :build do
  command = %(
    cd ~
    sudo rm -rf usergrid-stack
    cp -r /vagrant/usergrid-stack ~/
    cd ~/usergrid-stack
    sudo mvn clean install -DskipTests=true
    mkdir -p ~/issolated
    cp ~/usergrid-stack/standalone/target/usergrid-standalone-0.0.16-SNAPSHOT.jar ~/issolated/usergrid-standalone.jar
  ).strip.gsub("\n",' ; ').gsub(/\s+/,' ')
  puts "About to build usergrid. Takes about 10 minutes on my machine."
  system %(vagrant ssh --command "#{command}")
end

#desc "(re)Launch usergrid."
task :launch do
  def nohupasize(command)
    "nohup #{command} > output.txt 2> output.err < /dev/null &"
  end
  command = %(
    cd ~/issolated
    pkill -f usergrid-standalone
    #{nohupasize("java -jar usergrid-standalone.jar -db -init")}
  ).strip.gsub("\n",' ; ').gsub(/\s+/,' ')
  puts "About to try to run ** #{command} **"
  system %(vagrant ssh --command "#{command}")
end

#desc "Add pre-built usergrid"
task :download_built do
  command = %(
    mkdir -p ~/issolated
    cd ~/issolated
    curl -o usergrid-standalone.jar http://samsm.com/hidden/usergrid-standalone.jar
  ).strip.gsub("\n",' ; ').gsub(/\s+/,' ')
  puts "About to try to run ** #{command} **"
  system %(vagrant ssh --command "#{command}")
end

#desc "Create a box with usergrid running."
task :create_vm do
  #system "vagrant up"
  system "rake load_and_launch"
end