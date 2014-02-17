class bootstrap {

  # Silence Puppet and Vagrant annoyance about the puppet group
  group { 'puppet':
    ensure => 'present'
  }

  # Ensure local apt cache index is up to date before beginning
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }
}
