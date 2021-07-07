class desktop::terraform {
  # https://www.terraform.io/downloads.html

  $version = '1.0.1'
  $checksum = 'da94657593636c8d35a96e4041136435ff58bb0061245b7d0f82db4a7728cef3'

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
    '/home/asottile/opt/terraform-0.14.5',
  ]:
    ensure  => 'absent',
    recurse => true,
    force   => true,
  }
}
