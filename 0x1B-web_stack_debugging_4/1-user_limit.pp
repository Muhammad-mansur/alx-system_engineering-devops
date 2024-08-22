# Ensure the holberton user exists
user { 'holberton':
  ensure     => present,
  managehome => true,
  shell      => '/bin/bash',
}

# Set permissions on the user's home directory to avoid access issues
file { '/home/holberton':
  ensure  => directory,
  owner   => 'holberton',
  group   => 'holberton',
  mode    => '0755',
  require => User['holberton'],
}

# Ensure holberton user can open files without permission issues
file { '/home/holberton/somefile.txt':
  ensure  => file,
  owner   => 'holberton',
  group   => 'holberton',
  mode    => '0644',
  require => User['holberton'],
}

# Grant sudo access to the holberton user (if necessary)
file { '/etc/sudoers.d/holberton':
  ensure  => file,
  content => 'holberton ALL=(ALL) NOPASSWD: ALL',
  mode    => '0440',
  owner   => 'root',
  group   => 'root',
  require => User['holberton'],
}
