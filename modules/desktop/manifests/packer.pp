class desktop::packer {
  # https://www.packer.io/downloads.html

  $version = '1.6.1'
  $checksum = '8dcf97610e8c3907c23e25201dce20b498e1939e89878dec01de6975733c7729'

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
}
