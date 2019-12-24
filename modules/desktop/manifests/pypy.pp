class desktop::pypy {
  # https://pypy.org/download.html

  $pypy2 = 'pypy2.7-v7.3.0-linux64'
  $pypy2_sha256 = 'f4950a54378ac637da2a6defa52d6ffed96af12fcd5d74e1182fb834883c9826'
  $pypy3 = 'pypy3.6-v7.3.0-linux64'
  $pypy3_sha256 = 'd3d549e8f43de820ac3385b698b83fa59b4d7dd6cf3fe34c115f731e26ad8856'

  archive { "/tmp/${pypy2}.tar.bz2":
    ensure        => 'present',
    source        => "https://bitbucket.org/pypy/pypy/downloads/${pypy2}.tar.bz2",
    checksum      => $pypy2_sha256,
    checksum_type => 'sha256',
    extract       => true,
    extract_path  => '/home/asottile/opt',
    creates       => "/home/asottile/opt/${pypy2}/bin/pypy",
    user          => 'asottile',
    group         => 'asottile',
    require       => [Package['curl'], File['/home/asottile/opt']],
  }
  ['pypy', 'pypy2'].each |$bin| {
    file { "/home/asottile/bin/${bin}":
      ensure  => 'link',
      target  => "/home/asottile/opt/${pypy2}/bin/pypy",
      owner   => 'asottile',
      group   => 'asottile',
      require => [
        File['/home/asottile/bin'],
        Archive["/tmp/${pypy2}.tar.bz2"],
      ],
    }
  }

  archive { "/tmp/${pypy3}.tar.bz2":
    ensure        => 'present',
    source        => "https://bitbucket.org/pypy/pypy/downloads/${pypy3}.tar.bz2",
    checksum      => $pypy3_sha256,
    checksum_type => 'sha256',
    extract       => true,
    extract_path  => '/home/asottile/opt',
    creates       => "/home/asottile/opt/${pypy3}/bin/pypy3",
    user          => 'asottile',
    group         => 'asottile',
    require       => [Package['curl'], File['/home/asottile/opt']],
  }
  file { '/home/asottile/bin/pypy3':
    ensure  => 'link',
    target  => "/home/asottile/opt/${pypy3}/bin/pypy3",
    owner   => 'asottile',
    group   => 'asottile',
    require => [
      File['/home/asottile/bin'],
      Archive["/tmp/${pypy3}.tar.bz2"],
    ],
  }

  # purge old versions, remove when updated
  file { [
    '/home/asottile/opt/pypy2-v6.0.0-linux64',
    '/home/asottile/opt/pypy3-v6.0.0-linux64',
    '/home/asottile/opt/pypy2.7-v7.1.1-linux64',
    '/home/asottile/opt/pypy3.6-v7.1.1-linux64',
    '/home/asottile/opt/pypy2.7-v7.2.0-linux64',
    '/home/asottile/opt/pypy3.6-v7.2.0-linux64',
  ]:
    ensure  => 'absent',
    recurse => true,
    force   => true,
  }
}
