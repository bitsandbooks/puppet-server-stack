# ZFS class. This gets ZFS on Linux up and running.

class zfs {
  include apt
  
  # Add ZFS on Linux ppa.
  apt::ppa { 'ppa:zfs-native/stable': }
  
  # Install packages.
  package { 'ubuntu-zfs':
    ensure  => installed,
    require => Exec["apt-get update"],
  }
  
  file { 'zpool_mount_point':
    path    => "$zpool_mount_point",
    ensure  => directory,
    require => Package['ubuntu-zfs'],
  }
  
  zpool { "$zpool_name":
    ensure      => present,
    raidz       => $zpool_disks,
    raid_parity => "$zpool_parity",
    require     => File['zpool_mount_point'],
  }
}