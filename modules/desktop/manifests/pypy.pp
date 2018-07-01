class desktop::pypy {
  # https://pypy.org/download.html
  $pypy2 = 'pypy2-v6.0.0-linux64'
  $pypy2_sha256 = '6cbf942ba7c90f504d8d6a2e45d4244e3bf146c8722d64e9410b85eac6b5af67'
  $pypy3 = 'pypy3-v6.0.0-linux64'
  $pypy3_sha256 = '4cfffa292b9ef34bb6ba39cdbaa196c5c5cbbc5aa3faaa157cf45d7e34027048'

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
}
