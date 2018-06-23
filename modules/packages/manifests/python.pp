class packages::python {
  package { ['python-dev', 'python3-dev']: ensure => 'latest' }

  apt::ppa { 'ppa:deadsnakes/ppa': } ->
  package { 'python3.5-dev':
    ensure  => 'latest',
    require => Exec['apt_update'],
  }
  # TODO: remove once all have updated
  package { 'python2.6-dev': ensure => 'purged' }
}
