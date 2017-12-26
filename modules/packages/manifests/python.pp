class packages::python {
  package { ['python-dev', 'python3-dev']: ensure => 'latest' }

  apt::ppa { 'ppa:deadsnakes/ppa': } ->
  package { ['python2.6-dev', 'python3.4-dev', 'python3.6-dev']:
    ensure => 'latest',
  }
}
