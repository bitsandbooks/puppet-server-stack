/**
 * Title:     Puppet Home Server Stack.
 * Author:    [Rob Dumas](http://robertdumas.org)
 * Created:   15 February 2014
 * Copyright: Copyright (c) 2014 Rob Dumas.
 * License:   [GNU General Public License v2.0 - GNU Project - Free Software Foundation](http://www.gnu.org/licenses/gpl-2.0.html)
 */

# Your Virtulbox test instance
node 'ztest1.local' {
  # Define zpool variables.
  $zpool_name        = 'storage'
  $zpool_parity      = 'raidz2'
  $zpool_mount_point = "/$zpool_name"
  $zpool_disks       = "/vdev/vdisk1 /vdev/vdisk2 /vdev/vdisk3 /vdev/vdisk4 /vdev/vdisk5"
  
  # Define zfs variables.
  $zfs_datasets      = [ 'backups', 'data', 'home', 'media' ]
  
  include bootstrap
  include tools
  include zfs 
}

# Your home server
node 'zeddemore.local' {
  # Define zpool variables.
  $zpool_name        = 'storage'
  $zpool_parity      = 'raidz2'
  $zpool_mount_point = "/$zpool_name"
  $zpool_disks       = "/your/devs/here/as /space/separated/string"
  
  include bootstrap
  include tools
  include zfs
}
