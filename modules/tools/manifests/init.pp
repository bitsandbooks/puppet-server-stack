class tools {

  # Base package install list
  $packages = [
    'curl',
    'htop',
    'python-software-properties',
    'software-properties-common',
    'vim',
    'zsh',
  ]

  # Install packages
  package { $packages:
    ensure => latest,
    require => Exec["apt-get update"]
  }
}
