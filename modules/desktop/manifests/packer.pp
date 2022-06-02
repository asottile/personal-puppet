class desktop::packer(String $version, String $archive_name, String $sha256) {
  file { "/home/asottile/opt/packer-${version}":
    ensure  => 'directory',
    owner   => 'asottile',
    group   => 'asottile',
    require => File['/home/asottile/opt'],
  } ->
  archive { "/tmp/packer${version}.zip":
    ensure        => 'present',
    source        => "https://releases.hashicorp.com/packer/${version}/${archive_name}",
    checksum      => $sha256,
    checksum_type => 'sha256',
    extract       => true,
    extract_path  => "/home/asottile/opt/packer-${version}",
    creates       => "/home/asottile/opt/packer-${version}/packer",
    user          => 'asottile',
    group         => 'asottile',
    require       => Package['curl'],
  } ->
  file { '/home/asottile/bin/packer':
    ensure  => 'link',
    target  => "/home/asottile/opt/packer-${version}/packer",
    owner   => 'asottile',
    group   => 'asottile',
    require => File['/home/asottile/bin'],
  }

  tidy { 'purge old packer versions':
    path    => '/home/asottile/opt',
    recurse => 1,
    rmdirs  => true,
    matches => ['packer-*'],
  }
}
