class desktop::terraform {
  # https://www.terraform.io/downloads.html

  $version = '0.13.5'
  $checksum = 'f7b7a7b1bfbf5d78151cfe3d1d463140b5fd6a354e71a7de2b5644e652ca5147'

  file { "/home/asottile/opt/terraform-${version}":
    ensure  => 'directory',
    owner   => 'asottile',
    group   => 'asottile',
    require => File['/home/asottile/opt'],
  } ->
  archive { "/tmp/terraform${version}.zip":
    ensure        => 'present',
    source        => "https://releases.hashicorp.com/terraform/${version}/terraform_${version}_linux_amd64.zip",
    checksum      => $checksum,
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

  # purge old versions, remove when updated
  file { [
    '/home/asottile/opt/terraform-0.12.29',
  ]:
    ensure  => 'absent',
    recurse => true,
    force   => true,
  }
}
