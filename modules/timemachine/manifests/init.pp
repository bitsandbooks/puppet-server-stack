# Time Machine

class timemachine {

  group { "$admin_group": ensure => present, }

  user { "$backup_user":
    ensure      => present,
    gid         => "$admin_group",
    shell       => '/sbin/nologin',
    managehome  => false,
  }

  # Netatalk (AppleTalk)
  package { 'netatalk': 
    ensure  => installed, 
    require => User["$backup_user"],
  }

  service { 'netatalk': 
    ensure => running,
    require => Package['netatalk'],
  }

  file { '/etc/netatalk/AppleVolumes.default':
    ensure  => present,
    content => template('timemachine/AppleVolumes.default.erb'),
    require => Package['netatalk'],
    notify  => Service['netatalk'],
  }

  # Avahi (a.k.a. Zeroconf, Bonjour)
  package { 'avahi-daemon': 
    ensure => installed, 
    require => User["$backup_user"],
  }

  service { 'avahi-daemon': 
    ensure => running,
    require => Package['avahi-daemon'],
  }

  file { '/etc/avahi/services/afpd.service':
    ensure  => present,
    content => file('/etc/puppet/modules/timemachine/files/afpd.service'),
    require => Package['avahi-daemon'],
    notify  => Service['avahi-daemon'],
  }
}
