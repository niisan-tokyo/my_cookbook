
include_attribute "php::default"

default['php-fpm']['php_path'] = '/root/.phpenv/versions/'
default['php-fpm']['php_fpm_conf_name'] = 'etc/php-fpm.conf'
default['php-fpm']['php_fpm_bin_path'] = 'sbin/php-fpm'
default['php-fpm']['listen'] = '127.0.0.1:9000'
default['php-fpm']['user'] = 'nobody'
default['php-fpm']['group'] = 'nobody'