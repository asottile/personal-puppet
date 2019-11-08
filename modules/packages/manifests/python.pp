class packages::python {
  $ubuntu_pkgs = ['python-dev', 'python3-dev', 'python3-distutils']
  package { $ubuntu_pkgs: ensure => 'latest' }

  $deadsnakes_pkgs = ['python3.5-dev', 'python3.7-dev', 'python3.8-dev']
  apt::ppa { 'ppa:deadsnakes/ppa': } ->
  package { $deadsnakes_pkgs:
    ensure  => 'latest',
    require => Exec['apt_update'],
  }
}
