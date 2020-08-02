class packages::node {
  apt::key { '9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280':
    source => 'https://deb.nodesource.com/gpgkey/nodesource.gpg.key',
  } ->
  apt::source { 'nodesource':
    location => 'https://deb.nodesource.com/node_12.x',
    repos    => 'main',
    release  => $::lsbdistcodename,
  } ->
  package { 'nodejs':
    ensure  => 'latest',
    require => Exec['apt_update'],
  }
}
