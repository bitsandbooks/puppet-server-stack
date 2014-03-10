# ZFS class. This gets ZFS on Linux up and running.
class zfs {
  include apt
  
  # Add ZFS on Linux ppa.
  apt::ppa { 'ppa:zfs-native/stable': }
  
  # Install packages.
  package { 'ubuntu-zfs':
    ensure  => installed,
    require => Exec["apt-get update"] -> Apt::Ppa['ppa:zfs-native/stable'],
  }
  
  # Set zpool mount point.
  file { 'zpool_mount_point':
    path    => "$zpool_mount_point",
    ensure  => directory,
    require => Package['ubuntu-zfs'],
  }
  
  # Create the zpool.
  zpool { "$zpool_name":
    ensure      => present,
    raidz       => $zpool_disks,
    raid_parity => "$zpool_parity",
    require     => File['zpool_mount_point'],
  }

  # Set up compression on the zpool.
  zfs { "$zpool_name":
    compression => 'lzjb',
    require     => Zpool["$zpool_name"],
  }

  # Create datasets withing the zpool.
  zfs { $zfs_datasets:
    ensure  => present,
    require => Zfs["$zpool_name"],
  }

}