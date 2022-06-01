class desktop::pypy {
  # https://pypy.org/download.html

  $pypy3 = 'pypy3.9-v7.3.9-linux64'
  $pypy3_sha256 = '46818cb3d74b96b34787548343d266e2562b531ddbaf330383ba930ff1930ed5'

  file { "/home/asottile/opt/${pypy3}":
    ensure  => 'directory',
    owner   => 'asottile',
    group   => 'asottile',
    require => File['/home/asottile/opt'],
  } ->
  archive { "/tmp/${pypy3}.tar.bz2":
    ensure        => 'present',
    source        => "https://downloads.python.org/pypy/${pypy3}.tar.bz2",
    checksum      => $pypy3_sha256,
    checksum_type => 'sha256',
    extract       => true,
    extract_flags => {'tar' => '--strip-components=1 -xf'},
    extract_path  => "/home/asottile/opt/${pypy3}",
    creates       => "/home/asottile/opt/${pypy3}/bin/pypy3",
    user          => 'asottile',
    group         => 'asottile',
    require       => Package['curl'],
  } ->
  file { '/home/asottile/bin/pypy3':
    ensure  => 'link',
    target  => "/home/asottile/opt/${pypy3}/bin/pypy3",
    owner   => 'asottile',
    group   => 'asottile',
    require => File['/home/asottile/bin'],
  }

  tidy { 'purge old pypy versions':
    path    => '/home/asottile/opt',
    recurse => 1,
    rmdirs  => true,
    matches => ['pypy*'],
  }
}
