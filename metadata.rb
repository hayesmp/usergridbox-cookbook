name             'usergridbox'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures usergridbox'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'ubuntu'
supports 'debian'

recipe 'usergridbox', 'sets up a usergrid unbuntu server'
recipe 'usergridbox::usergrind', 'recipe to setup usergrid'
#recipe "usergridbox::ruby", "setup a ruby version manager `rbenv`."

depends 'apt'
depends 'build-essential'
depends 'openssl'
depends 'emacs'
depends 'curl'
depends 'git'
depends 'java'
#depends 'rbenv'
depends 'thrift'
depends 'maven'
#depends 'cassandra'
depends 'tomcat'
