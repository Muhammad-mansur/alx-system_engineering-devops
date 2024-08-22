# Update file descriptor limits for the holberton user
exec {'increase-soft-limit':
  provider => shell,
  command  => 'sed -i "s/holberton soft nofile [0-9]*/holberton soft nofile 50000/" /etc/security/limits.conf',
  unless   => 'grep -q "holberton soft nofile 50000" /etc/security/limits.conf',
  before   => Exec['increase-hard-limit'],
}

exec {'increase-hard-limit':
  provider => shell,
  command  => 'sed -i "s/holberton hard nofile [0-9]*/holberton hard nofile 50000/" /etc/security/limits.conf',
  unless   => 'grep -q "holberton hard nofile 50000" /etc/security/limits.conf',
}

# Reload or restart any service if necessary to apply these changes
exec { 'reload_limits':
  provider => shell,
  command  => 'sudo sysctl -p',
  subscribe => Exec['increase-hard-limit'],
  refreshonly => true,
}
