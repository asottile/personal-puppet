class desktop::node {
  # https://nodejs.org/dist

  $node = 'v18.0.0'
  $archive_name = "node-${node}-linux-x64"
  $node_sha256 = 'ffe94f0a3804e186b53f9480f4ef3a0c9ec450d7da45526438f6d37be9f4d22e'

  archive { "/tmp/${archive_name}.tar.xz":
    ensure        => 'present',
    source        => "https://nodejs.org/dist/${node}/${archive_name}.tar.xz",
    checksum      => $node_sha256,
    checksum_type => 'sha256',
    extract       => true,
    extract_path  => '/home/asottile/opt',
    creates       => "/home/asottile/opt/${archive_name}/bin/node",
    user          => 'asottile',
    group         => 'asottile',
    require       => [Package['curl'], File['/home/asottile/opt']],
  }
  ['node', 'npm', 'npx', 'corepack'].each |$bin| {
      file { "/home/asottile/bin/${bin}":
        ensure  => 'link',
        target  => "/home/asottile/opt/${archive_name}/bin/${bin}",
        owner   => 'asottile',
        group   => 'asottile',
        require => [
          File['/home/asottile/bin'],
          Archive["/tmp/${archive_name}.tar.xz"],
        ],
      }
  }

  # purge old versions, remove when updated
  file { [
  ]:
    ensure  => 'absent',
    recurse => true,
    force   => true,
  }
}
