class packages::python {
  $ubuntu_pkgs = ['python2-dev', 'python3-dev', 'python3-distutils']
  package { $ubuntu_pkgs: ensure => 'latest' } ->
  file { '/etc/python3.8/sitecustomize.py':
    ensure  => present,
    content => '',
  }

  $deadsnakes_pkgs = [
    'python3.6-dev', 'python3.6-distutils',
    'python3.7-dev', 'python3.7-distutils',
    'python3.9-dev',
    'python3.10-dev', 'python3.10-distutils',
    'python3.11-dev', 'python3.11-distutils',
    'python3.12-dev', 'python3.12-distutils',
  ]
  apt::ppa { 'ppa:deadsnakes/ppa': } ->
  package { $deadsnakes_pkgs:
    ensure  => 'latest',
    require => Exec['apt_update'],
  }
}
