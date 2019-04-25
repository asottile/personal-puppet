class desktop::pypy {
  # https://pypy.org/download.html

  $pypy2 = 'pypy2.7-v7.1.1-linux64'
  $pypy2_sha256 = '73b09ef0860eb9ad7997af3030b22909806a273d90786d78420926df53279d66'
  $pypy3 = 'pypy3.6-v7.1.1-linux64'
  $pypy3_sha256 = '8014f63b1a34b155548852c7bf73aab2d41ebddf2c8fb603dc9dd8509be93db0'

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
  ]:
    ensure  => 'absent',
    recurse => true,
    force   => true,
  }
}
