class desktop::go {
  # https://golang.org/dl/
  $go = 'go1.16.linux-amd64'
  $sha256 = '013a489ebb3e24ef3d915abe5b94c3286c070dfe0818d5bca8108f1d6e8440d2'

  file { "/home/asottile/opt/${go}":
    ensure => 'directory',
    owner  => 'asottile',
    group  => 'asottile',
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
    require       => [Package['curl'], File['/home/asottile/opt']],
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

  # purge old versions, remove when updated
  file { [
    '/home/asottile/opt/go1.14.2.linux-amd64',
  ]:
    ensure  => 'absent',
    recurse => true,
    force   => true
  }
}
