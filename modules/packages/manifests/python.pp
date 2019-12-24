class packages::python {
  $ubuntu_pkgs = ['python-dev', 'python3-dev', 'python3-distutils']
  package { $ubuntu_pkgs: ensure => 'latest' } ->
  file { '/etc/python3.6/sitecustomize.py':
    ensure  => present,
    content => '',
  }

  $deadsnakes_pkgs = ['python3.7-dev', 'python3.8-dev', 'python3.9-dev']
  apt::ppa { 'ppa:deadsnakes/ppa': } ->
  package { $deadsnakes_pkgs:
    ensure  => 'latest',
    require => Exec['apt_update'],
  }

  ['python3.7', 'python3.8', 'python3.9'].each |String $python| {
    file {"/etc/${python}/sitecustomize.py":
      ensure  => present,
      content => '',
      require => Package["${python}-dev"],
    }
  }
}
