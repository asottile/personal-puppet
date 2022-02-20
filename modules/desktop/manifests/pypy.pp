class desktop::pypy {
  # https://pypy.org/download.html

  $pypy3 = 'pypy3.9-v7.3.8-linux64'
  $pypy3_sha256 = '129a055032bba700cd1d0acacab3659cf6b7180e25b1b2f730e792f06d5b3010'

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
    '/home/asottile/opt/pypy2.7-v7.3.6-linux64',
    '/home/asottile/opt/pypy3.8-v7.3.6-linux64',
    '/home/asottile/opt/pypy3.8-v7.3.7-linux64',
  ]:
    ensure  => 'absent',
    recurse => true,
    force   => true,
  }
  ['pypy', 'pypy2'].each |$bin| {
    file { "/home/asottile/bin/${bin}":
      ensure  => 'absent',
    }
  }
}
