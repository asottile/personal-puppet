class desktop::pypy {
  # https://pypy.org/download.html

  $pypy2 = 'pypy2.7-v7.3.2-linux64'
  $pypy2_sha256 = '8d4f08116a97153a0f739de8981874d544b564cbc87dd064cca33f36c29da13b'
  $pypy3 = 'pypy3.7-v7.3.2-linux64'
  $pypy3_sha256 = 'a285ddcbc909d68c648585fae4f33b0ba24961bb4e8fafe5874cf725d6e83df6'

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
  ]:
    ensure  => 'absent',
    recurse => true,
    force   => true,
  }
}
