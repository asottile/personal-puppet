class packages::python {
  package { 'python3-dev': ensure => 'latest' } ->
  file { '/etc/python3.12/sitecustomize.py':
    ensure  => present,
    content => '',
  }

  $deadsnakes_pkgs = [
    'python3.7-dev', 'python3.7-distutils',
    'python3.8-dev', 'python3.8-distutils',
    'python3.9-dev', 'python3.9-distutils',
    'python3.10-dev', 'python3.10-distutils',
    'python3.11-dev',
    'python3.13-dev',
  ]
  apt::ppa { 'ppa:deadsnakes/ppa': } ->
  package { $deadsnakes_pkgs:
    ensure  => 'latest',
    require => Exec['apt_update'],
  }
}
