class packages::python {
  package { ['python-dev', 'python3-dev']: ensure => 'latest' }

  $deadsnakes_pkgs = [
    'python3.5-dev', 'python3.7-dev', 'python3.8-dev', 'python3.8-distutils',
  ]
  apt::ppa { 'ppa:deadsnakes/ppa': } ->
  package { $deadsnakes_pkgs:
    ensure  => 'latest',
    require => Exec['apt_update'],
  }
  # TODO: remove once all have updated
  package { 'python2.6-dev': ensure => 'purged' }
}
