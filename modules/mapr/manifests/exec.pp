class mapr::exec {

  $cluster = hiera('mapr::clustername')
  $cldbs = join(hiera('mapr::cldbs'),',')
  $zks = join(hiera('mapr::zks'),',')

  file { '/usr/local/bin/getdisks.py':
    path => '/usr/local/bin/getdisks.py',
    ensure => 'file',
    owner => 'root',
    group => 'root',
    mode => '755',
    source => 'puppet:///modules/mapr/getdisks.py',
  } 

  exec { 'getdisks.py':
    command => '/usr/local/bin/getdisks.py',
    require => File['/usr/local/bin/getdisks.py'],
    refreshonly => true,
  }

  user { 'mapr':
    ensure => 'present',
    uid => '5000',
    gid => '5000',
    home => '/opt/mapr',
    shell => '/bin/bash',
    before => Exec['configure.sh'],
  }

  group { 'mapr':
    ensure => 'present',
    gid => '5000',
    before => User['mapr'],
  }

  exec { 'configure.sh':
    require => Exec['getdisks.py'],
    command => "/opt/mapr/server/configure.sh -N $cluster -C $cldbs -Z $zks -F /tmp/disks.txt --isvm -on-prompt-cont y",
    creates => '/opt/mapr/conf/disktab'
  }
}
