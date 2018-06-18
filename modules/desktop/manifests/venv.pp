class desktop::venv {
  $packages = [
    'flake8', 'pre-commit', 'tox', 'tox-pip-extensions',
    'tox-virtualenv-no-download', 'twine', 'virtualenv',
  ]
  $binaries = ['flake8', 'pre-commit', 'tox', 'twine', 'virtualenv']

  exec { 'create ~/opt/venv':
    command => join([
      'curl https://asottile.github.io/get-virtualenv.py | ',
      'python3 - /home/asottile/opt/venv',
    ]),
    unless  => join([
        'test -x /home/asottile/opt/venv/bin/python && ',
        '/home/asottile/opt/venv/bin/python -c ',
        '"import ctypes, datetime, io, os, ssl, weakref"',
    ]),
    user    => 'asottile',
    path    => '/usr/sbin:/usr/bin:/bin',
    require => Package['curl'],
  }

  # TODO: this is quite slow, ideally I'd like something like
  # venv { '/home/asottile/opt/venv':
  #     user => 'asottile',
  #     packages => $packages,
  # }
  $packages.each |$pkg| {
    exec { "pip install ${pkg} into ~/opt/venv":
      command => "/home/asottile/opt/venv/bin/pip install ${pkg}",
      unless  => "/home/asottile/opt/venv/bin/pip freeze | grep '^${pkg}=='",
      user    => 'asottile',
      require => Exec['create ~/opt/venv'],
    }
  }

  $binaries.each |$bin| {
    file { "/home/asottile/bin/${bin}":
      ensure  => 'link',
      target  => "/home/asottile/opt/venv/bin/${bin}",
      owner   => 'asottile',
      group   => 'asottile',
      require => [
        File['/home/asottile/bin'],
        Exec["pip install ${bin} into ~/opt/venv"],
      ],
    }
  }
}
