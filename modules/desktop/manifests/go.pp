class desktop::go {
  # https://golang.org/dl/
  $go = 'go1.14.2.linux-amd64'
  $sha256 = '6272d6e940ecb71ea5636ddb5fab3933e087c1356173c61f4a803895e947ebb3'

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

  # this is no longer present in modern go
  file { '/home/asottile/bin/godoc':
    ensure => 'absent',
  }

  # purge old versions, remove when updated
  file { [
    '/home/asottile/opt/go',
    '/home/asottile/opt/go1.12.5.linux-amd64',
    '/home/asottile/opt/go1.13.5.linux-amd64',
  ]:
    ensure  => 'absent',
    recurse => true,
    force   => true
  }
}
