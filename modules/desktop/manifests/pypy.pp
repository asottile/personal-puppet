class desktop::pypy {
  # https://pypy.org/download.html

  $pypy2 = 'pypy2.7-v7.3.3-linux64'
  $pypy2_sha256 = 'f412b602ccd6912ddee0e7523e0e38f4b2c7a144449c2cad078cffbdb66fd7b1'
  $pypy3 = 'pypy3.7-v7.3.3-linux64'
  $pypy3_sha256 = '37e2804c4661c86c857d709d28c7de716b000d31e89766599fdf5a98928b7096'

  archive { "/tmp/${pypy2}.tar.bz2":
    ensure        => 'present',
    source        => "https://downloads.python.org/pypy/${pypy2}.tar.bz2",
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
    source        => "https://downloads.python.org/pypy/${pypy3}.tar.bz2",
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
    '/home/asottile/opt/pypy2.7-v7.3.1-linux64',
    '/home/asottile/opt/pypy3.6-v7.3.1-linux64',
    '/home/asottile/opt/pypy2.7-v7.3.2-linux64',
    '/home/asottile/opt/pypy3.7-v7.3.2-linux64',
  ]:
    ensure  => 'absent',
    recurse => true,
    force   => true,
  }
}
