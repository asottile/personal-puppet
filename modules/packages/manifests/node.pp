class packages::node {
  apt::key { '9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280':
    ensure => 'absent'
  } ->
  apt::source { 'nodesource': ensure => 'absent' } ->
  package { 'nodejs': ensure  => 'purged' }
}
