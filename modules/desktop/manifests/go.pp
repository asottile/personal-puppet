class desktop::go {
  # https://golang.org/dl/
  $version = 'go1.10.3.linux-amd64.tar.gz'
  $sha256 = 'fa1b0e45d3b647c252f51f5e1204aba049cde4af177ef9f2181f43004f901035'

  archive { "/tmp/${version}":
    ensure        => 'present',
    source        => "https://dl.google.com/go/${version}",
    checksum      => $sha256,
    checksum_type => 'sha256',
    extract       => true,
    extract_path  => '/home/asottile/opt',
    creates       => '/home/asottile/opt/go/bin/go',
    user          => 'asottile',
    group         => 'asottile',
    require       => [Package['curl'], File['/home/asottile/opt']],
  }
  ['go', 'godoc', 'gofmt'].each |$bin| {
    file { "/home/asottile/bin/${bin}":
      ensure  => 'link',
      target  => "/home/asottile/opt/go/bin/${bin}",
      owner   => 'asottile',
      group   => 'asottile',
      require => [File['/home/asottile/bin'], Archive["/tmp/${version}"]],
    }
  }
}
