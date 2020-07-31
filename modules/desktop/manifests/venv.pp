class desktop::venv {
  $packages = [
    'aactivator', 'babi', 'flake8', 'pre-commit', 'tox', 'twine', 'virtualenv',
  ]
  $venv = '/home/asottile/opt/venv'

  exec { "create ${venv}":
    command => join([
      "rm -rf ${venv} && ",
      'curl --silent --location --output /tmp/virtualenv.pyz https://bootstrap.pypa.io/virtualenv.pyz && ',
      "python3 /tmp/virtualenv.pyz ${venv} && ",
      'rm -rf /tmp/virtualenv.pyz',
    ]),
    unless  => join([
        "test -x ${venv}/bin/python && ",
        "info=\"$(${venv}/bin/python -S -c 'import sys;print(\".\".join(str(p) for p in sys.version_info))')\" && ",
        "grep \"^version_info = \$info$\" ${venv}/pyvenv.cfg",
    ]),
    user    => 'asottile',
    path    => '/usr/sbin:/usr/bin:/bin',
    require => [Package['curl'], File['/home/asottile/opt']],
  }

  # TODO: this is quite slow, ideally I'd like something like
  # venv { '/home/asottile/opt/venv':
  #     user => 'asottile',
  #     packages => $packages,
  # }
  $packages.each |$pkg| {
    exec { "pip install ${pkg} into ${venv}":
      command => "${venv}/bin/pip install ${pkg}",
      unless  => "${venv}/bin/pip freeze | grep '^${pkg}=='",
      user    => 'asottile',
      require => Exec["create ${venv}"],
    }
  }

  $packages.each |$bin| {
    file { "/home/asottile/bin/${bin}":
      ensure  => 'link',
      target  => "${venv}/bin/${bin}",
      owner   => 'asottile',
      group   => 'asottile',
      require => [
        File['/home/asottile/bin'],
        Exec["pip install ${bin} into ${venv}"],
      ],
    }
  }
}
