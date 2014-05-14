#
# Cookbook Name:: dev_conf
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

timezone = node['dev_conf']['timezone']

bash 'set timezone' do
  code <<-EOS
    rm -f /etc/localtime
    cp -p /usr/share/zoneinfo/#{timezone} /etc/localtime
  EOS
end