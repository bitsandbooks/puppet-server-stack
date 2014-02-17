# zfs.pp
class zfs {
  include apt, zfs::zpool
  
  # add ZFS on Linux ppa.  
  apt::ppa { 'ppa:zfs-native/stable': }
  
  # install packages
  package { 'ubuntu-zfs':
    ensure  => installed,
    require => Exec["apt-get update"],
  }
  
  file { 'zpool-mount-point':
    path    => "$zpool_mount_point",
    ensure  => 'directory',
    require => Package['ubuntu-zfs'],
  }
}