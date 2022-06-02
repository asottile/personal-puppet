class desktop::packer(String $version, String $archive_name, String $sha256) {
  file { "/home/asottile/opt/${archive_name}":
    ensure  => 'directory',
    owner   => 'asottile',
    group   => 'asottile',
    require => File['/home/asottile/opt'],
  } ->
  archive { "/tmp/${archive_name}.zip":
    ensure        => 'present',
    source        => "https://releases.hashicorp.com/packer/${version}/${archive_name}.zip",
    checksum      => $sha256,
    checksum_type => 'sha256',
    extract       => true,
    extract_path  => "/home/asottile/opt/${archive_name}",
    creates       => "/home/asottile/opt/${archive_name}/packer",
    user          => 'asottile',
    group         => 'asottile',
    require       => Package['curl'],
  } ->
  file { '/home/asottile/bin/packer':
    ensure  => 'link',
    target  => "/home/asottile/opt/${archive_name}/packer",
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
