# Cookbook Name:: php
# Recipe:: phalcon
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

dir_name = node['php']['env_root'] + '/versions/' + node['php']['version'] + '/etc/conf.d/'

#gitからphalcon取ってきて
git "/tmp/cphalcon" do
  repository "git://github.com/phalcon/cphalcon.git"
  revision node['phalcon']['version']
  action :sync
#  not_if "php -m | grep phalcon"
end

#インストールしちゃう
bash "install cphalcon" do
  cwd "/tmp/cphalcon/build"
  code <<-EOF
  export PATH="$HOME/.phpenv/bin:$PATH"
  eval "$(phpenv init -)"
  cd /tmp/cphalcon/build
  ./install
  echo "extension=phalcon.so" > #{dir_name}phalcon.ini
  EOF
  not_if "php -m | grep phalcon"
end