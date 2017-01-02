class mapr::install inherits mapr::packages::base {

  $mapr_roles = hiera('mapr::roles')

  $mapr_roles.each |$role| {
    package { $mapr_roles[$role[0]]['packages']: }
  }

}
