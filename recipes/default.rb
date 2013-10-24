#
# Cookbook Name:: usergridbox
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'build-essential'
include_recipe 'openssl'
include_recipe 'curl'
include_recipe 'git'
include_recipe 'java'
include_recipe 'thrift'
include_recipe 'maven'
include_recipe 'cassandra::tarball'
include_recipe 'tomcat'

include_recipe 'usergridbox::usergrid'