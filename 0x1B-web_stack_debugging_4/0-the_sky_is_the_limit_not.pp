# Increase the file descriptor limit for Nginx to handle more connections

# Modify the worker_rlimit_nofile directive in the Nginx configuration
exec { 'increase_nginx_file_limit':
  command => 'sed -i "s/worker_rlimit_nofile [0-9]*;/worker_rlimit_nofile 4096;/" /etc/nginx/nginx.conf',
  path    => '/usr/bin:/bin',
  unless  => 'grep -q "worker_rlimit_nofile 4096;" /etc/nginx/nginx.conf',
}

# Reload the Nginx service to apply the updated configuration
exec { 'reload_nginx_service':
  command => 'systemctl reload nginx',
  path    => '/usr/bin:/bin:/sbin',
  subscribe => Exec['increase_nginx_file_limit'],
  refreshonly => true,
}
