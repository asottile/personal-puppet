class desktop::terraform(String $version, String $archive_name, String $sha256) {
  file { "/home/asottile/opt/terraform-${version}":
    ensure  => 'directory',
    owner   => 'asottile',
    group   => 'asottile',
    require => File['/home/asottile/opt'],
  } ->
  archive { "/tmp/terraform${version}.zip":
    ensure        => 'present',
    source        => "https://releases.hashicorp.com/terraform/${version}/${archive_name}",
    checksum      => $sha256,
    checksum_type => 'sha256',
    extract       => true,
    extract_path  => "/home/asottile/opt/terraform-${version}",
    creates       => "/home/asottile/opt/terraform-${version}/terraform",
    user          => 'asottile',
    group         => 'asottile',
    require       => Package['curl'],
  } ->
  file { '/home/asottile/bin/terraform':
    ensure  => 'link',
    target  => "/home/asottile/opt/terraform-${version}/terraform",
    owner   => 'asottile',
    group   => 'asottile',
    require => File['/home/asottile/bin'],
  }

  tidy { 'purge old terraform versions':
    path    => '/home/asottile/opt',
    recurse => 1,
    rmdirs  => true,
    matches => ['terraform-*'],
  }
}
