class desktop::go(String $go, String $sha256) {
  file { "/home/asottile/opt/${go}":
    ensure  => 'directory',
    owner   => 'asottile',
    group   => 'asottile',
    require => File['/home/asottile/opt'],
  } ->
  archive { "/tmp/${go}.tar.gz":
    ensure        => 'present',
    source        => "https://dl.google.com/go/${go}.tar.gz",
    checksum      => $sha256,
    checksum_type => 'sha256',
    extract       => true,
    extract_path  => "/home/asottile/opt/${go}",
    creates       => "/home/asottile/opt/${go}/go/bin/go",
    user          => 'asottile',
    group         => 'asottile',
    require       => Package['curl'],
  }
  ['go', 'gofmt'].each |$bin| {
    file { "/home/asottile/bin/${bin}":
      ensure  => 'link',
      target  => "/home/asottile/opt/${go}/go/bin/${bin}",
      owner   => 'asottile',
      group   => 'asottile',
      require => [File['/home/asottile/bin'], Archive["/tmp/${go}.tar.gz"]],
    }
  }

  tidy { 'purge old go versions':
    path    => '/home/asottile/opt',
    recurse => 1,
    rmdirs  => true,
    matches => ['go*'],
  }
}
