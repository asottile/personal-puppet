class desktop::venv {
  $packages = [
    'aactivator', 'awshelp', 'babi', 'flake8', 'pre-commit', 'tox', 'twine',
    'virtualenv',
  ]
  $libraries = ['setuptools', 'wheel']
  $venv = '/home/asottile/opt/venv'

  util::virtualenv { $venv: venv => $venv }

  # TODO: this is quite slow, ideally I'd like something like
  # venv { '/home/asottile/opt/venv':
  #     user => 'asottile',
  #     packages => $packages,
  # }
  ($packages + $libraries).each |$pkg| {
    util::pip {"${venv}(${pkg})":
      pkg     => $pkg,
      venv    => $venv,
      require => Util::Virtualenv[$venv],
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
        Util::Pip["${venv}(${bin})"],
      ],
    }
  }

  # awscli deps conflict a lot so put them in their own environment
  $venv_aws = '/home/asottile/opt/awscli'
  util::virtualenv { $venv_aws: venv => $venv_aws } ->
  util::pip { "${venv_aws}(awscli)": pkg => 'awscli', venv => $venv_aws} ->
  file { '/home/asottile/bin/aws':
    ensure  => 'link',
    target  => "${venv_aws}/bin/aws",
    owner   => 'asottile',
    group   => 'asottile',
    require => [
      File['/home/asottile/bin'],
      Util::Pip["${venv_aws}(awscli)"],
    ],
  }

  file { ['/home/asottile/bin/az', '/home/asottile/opt/azcli']:
    ensure  => 'absent',
    recurse => true,
    force   => true,
  }
}
