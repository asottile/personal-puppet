class packages::firefox {
  apt::ppa { 'ppa:mozillateam/ppa': } ->
  apt::pin { 'firefox-ppa-pin':
    originator => 'LP-PPA-mozillateam',
    priority   => 700,
  } ->
  package { 'firefox':
    ensure  => 'latest',
    require => Exec['apt_update'],
  }

  # unattended-upgrades does not respect apt pinning
  package { 'unattended-upgrades': ensure => 'purged' }
}
