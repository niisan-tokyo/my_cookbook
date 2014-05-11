#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

version = node['git']['version'];
file = "git-#{version}";

bash "install git" do 
  cwd "/tmp"
  not_if "ls | grep git"
  code <<-EOH
        wget https://git-core.googlecode.com/files/#{file}.tar.gz
        tar zxvf #{file}.tar.gz
        rm #{file}.tar.gz
        cd #{file}/
        ./configure
        make
        make install
    EOH
end