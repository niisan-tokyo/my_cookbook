#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#リポジトリがない場合は追加する
execute 'install_nginx_repo' do
  not_if 'ls /etc/yum.repos.d/nginx.repo'
  command 'rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm'
end

#設定ファイルを突っ込む
cookbook_file '/etc/yum.repos.d/nginx.repo' do
  not_if 'ls /etc/yum.repos.d/nginx.repo'
  owner 'root'
  group 'root'
  mode '0644'
  source 'nginx.repo'
end

#インストール
package 'nginx' do
  :install
end

#スタート
#service 'nginx' do
#  action [ :enable, :start ]
#end
