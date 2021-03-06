/**
 * Title:     Puppet Home Server Stack.
 * Author:    [Rob Dumas](http://robertdumas.org)
 * Created:   15 February 2014
 * Copyright: Copyright (c) 2014 Rob Dumas.
 * License:   [GNU General Public License v2.0](http://www.gnu.org/licenses/gpl-2.0.html)
 */

# Virtualbox test environment. Vdisks are pre-allocated 128MB files. 
node 'ztest1.local' {
  # Define zpool variables.
  $zpool_name         = 'storage'
  $zpool_parity       = 'raidz2'
  $zpool_mount_point  = "/$zpool_name"
  $zpool_disks        = [ '/vdev/vdisk1', 
                          '/vdev/vdisk2',
                          '/vdev/vdisk3',
                          '/vdev/vdisk4',
                          '/vdev/vdisk5', ]
  
  include bootstrap
  include tools
  include zfs
}

node 'zeddemore.local' {
  # Define zpool variables.
  $zpool_name         = 'storage'
  $zpool_parity       = 'raidz2'
  $zpool_mount_point  = "/$zpool_name"
  $zpool_disks        = [ '/dev/disk/by-id/ata-WDC_WD10EZEX-00KUWA0_WD-WCC1S5846501', 
                          '/dev/disk/by-id/ata-WDC_WD10EZEX-00KUWA0_WD-WCC1S5849000', 
                          '/dev/disk/by-id/ata-WDC_WD10EZEX-00RKKA0_WD-WMC1S6620320', 
                          '/dev/disk/by-id/ata-WDC_WD10EZEX-00KUWA0_WD-WCC1S5439564', 
                          '/dev/disk/by-id/ata-WDC_WD10EZEX-00RKKA0_WD-WCC1S5840993', ]

  include bootstrap
  include tools
  include zfs
}
