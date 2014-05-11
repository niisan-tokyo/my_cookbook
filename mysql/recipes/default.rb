#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
version = node['mysql']['version']
full_version = "#{version}.#{node['mysql']['minor_version']}"


#mysql パッケージのインストール
node['mysql']['packages'].each do |packs|
  bash packs do
    cwd "/tmp"
    not_if "ls /tmp | grep MySQL-#{packs}-#{full_version}-1.el6.x86_64.rpm"
    code <<-EOS
      wget ftp://ftp.jaist.ac.jp/pub/mysql/Downloads/MySQL-#{version}/MySQL-#{packs}-#{full_version}-1.el6.x86_64.rpm
    EOS
  end
  
  package packs do
    source "/tmp/MySQL-#{packs}-#{full_version}-1.el6.x86_64.rpm"
    action :install
  end
end

#起動
service "mysql" do
  service_name "mysql"
  supports :start => true, :stop => true, :restart => true, :reload => true
  action [ :enable, :start ]
end