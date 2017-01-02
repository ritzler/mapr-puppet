class mapr::packages::base {

  Package { ensure => 'installed' }

  file { '/etc/yum.repos.d/maprtech.repo':
    ensure => 'file',
    owner => 'root',
    group => 'root',
    mode => '644',
    source => 'puppet:///modules/mapr/maprtech.repo',
  } ->
  package { hiera('mapr::packages::base'): }

}

class mapr::packages {
  class { '::mapr::install': } ~>
  class { '::mapr::exec': }
}
