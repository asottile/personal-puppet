class desktop::packer {
  # https://releases.hashicorp.com/packer/

  $version = '1.8.0'
  $checksum = '94c5d65386fa8f17e36d3496fbbdf18d3bfab01306aa8000c14656b63070b7c2'

  file { "/home/asottile/opt/packer-${version}":
    ensure  => 'directory',
    owner   => 'asottile',
    group   => 'asottile',
    require => File['/home/asottile/opt'],
  } ->
  archive { "/tmp/packer${version}.zip":
    ensure        => 'present',
    source        => "https://releases.hashicorp.com/packer/${version}/packer_${version}_linux_amd64.zip",
    checksum      => $checksum,
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
