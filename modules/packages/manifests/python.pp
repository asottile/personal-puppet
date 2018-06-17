class packages::python {
  package { ['python-dev', 'python3-dev']: ensure => 'latest' }

  apt::ppa { 'ppa:deadsnakes/ppa': } ->
  package { ['python2.6-dev', 'python3.5-dev']:
    ensure  => 'latest',
    require => Exec['apt_update'],
  }
}
