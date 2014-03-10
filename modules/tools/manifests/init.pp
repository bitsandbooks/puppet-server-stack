# Tools class. Packages that should be installed by default go here.

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
