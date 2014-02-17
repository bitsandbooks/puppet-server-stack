class bootstrap {

  # Ensure puppet group exists. (Otherwise, what's the point?)
  group { 'puppet':
    ensure => 'present'
  }

  # Ensure local apt cache index is up to date before beginning
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }
}
