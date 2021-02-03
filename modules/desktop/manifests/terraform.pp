class desktop::terraform {
  # https://www.terraform.io/downloads.html

  $version = '0.14.5'
  $checksum = '2899f47860b7752e31872e4d57b1c03c99de154f12f0fc84965e231bc50f312f'

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
    '/home/asottile/opt/terraform-0.13.5',
  ]:
    ensure  => 'absent',
    recurse => true,
    force   => true,
  }
}
