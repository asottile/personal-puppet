class desktop::packer {
  # https://www.packer.io/downloads.html

  $version = '1.6.4'
  $checksum = 'a20ec68e9eb6e1d6016481003f705babbecc28e234f8434f3a35f675cb200ea8'

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

  # purge old versions, remove when updated
  file { [
    '/home/asottile/opt/packer-1.6.1',
  ]:
    ensure  => 'absent',
    recurse => true,
    force   => true,
  }
}
