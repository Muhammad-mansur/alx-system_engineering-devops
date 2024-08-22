# Enhance Nginx's ability to manage higher traffic volumes

# Adjust the ULIMIT setting in the Nginx configuration file
exec { 'update_nginx_ulimit':
  command => 'sed -i "s/1024/4096/" /etc/nginx/nginx.conf',
  path    => '/usr/bin:/bin',
  onlyif  => 'grep -q "worker_rlimit_nofile 1024;" /etc/nginx/nginx.conf',
}

# Reload Nginx to apply the new settings
exec { 'reload_nginx_service':
  command => 'systemctl reload nginx',
  path    => '/usr/bin:/bin:/sbin',
  require => Exec['update_nginx_ulimit'],
}
