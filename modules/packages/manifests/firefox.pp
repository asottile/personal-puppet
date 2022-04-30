class packages::firefox {
  apt::ppa { 'ppa:mozillateam/firefox-next': } ->
  apt::pin { 'firefox-ppa-pin':
    originator => 'LP-PPA-mozillateam-firefox-next',
    priority   => 700,
  } ->
  package { 'firefox':
    ensure  => 'latest',
    require => Exec['apt_update'],
  }

  # unattended-upgrades does not respect apt pinning
  package { 'unattended-upgrades': ensure => 'purged' }
}
