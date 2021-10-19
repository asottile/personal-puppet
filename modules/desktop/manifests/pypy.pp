class desktop::pypy {
  # https://pypy.org/download.html

  $pypy2 = 'pypy2.7-v7.3.6-linux64'
  $pypy2_sha256 = '82127f43fae6ce75d47d6c4539f8c1ea372e9c2dbfa40fae8b58351d522793a4'
  $pypy3 = 'pypy3.8-v7.3.6-linux64'
  $pypy3_sha256 = '8579ea990e95d2b7e101ef47fd9ebf25a9500d5086e8f708c43f9bae83306ece'

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
    '/home/asottile/opt/pypy2.7-v7.3.3-linux64',
    '/home/asottile/opt/pypy3.7-v7.3.3-linux64',
    '/home/asottile/opt/pypy2.7-v7.3.5-linux64',
    '/home/asottile/opt/pypy3.7-v7.3.5-linux64',
  ]:
    ensure  => 'absent',
    recurse => true,
    force   => true,
  }
}
