class desktop::node(String $node, String $archive_name, String $sha256) {
  file { "/home/asottile/opt/${archive_name}":
    ensure  => 'directory',
    owner   => 'asottile',
    group   => 'asottile',
    require => File['/home/asottile/opt'],
  } ->
  archive { "/tmp/${archive_name}.tar.xz":
    ensure        => 'present',
    source        => "https://nodejs.org/dist/${node}/${archive_name}.tar.xz",
    checksum      => $sha256,
    checksum_type => 'sha256',
    extract       => true,
    extract_flags => {'unxz' => '-c', 'tar' => '--strip-components=1 -xf'},
    extract_path  => "/home/asottile/opt/${archive_name}",
    creates       => "/home/asottile/opt/${archive_name}/bin/node",
    user          => 'asottile',
    group         => 'asottile',
    require       => Package['curl'],
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

  tidy { 'purge old node versions':
    path    => '/home/asottile/opt',
    recurse => 1,
    rmdirs  => true,
    matches => ['node-*'],
  }
}
