class desktop::podman {
  file { '/home/asottile/bin/docker':
    ensure  => 'link',
    target  => '/usr/bin/podman',
    owner   => 'asottile',
    group   => 'asottile',
    require => [Package['podman'], File['/home/asottile/bin']],
  }

  file { '/home/asottile/.config/containers':
    ensure => 'directory',
    owner  => 'asottile',
    group  => 'asottile',
  } ->
  file { '/home/asottile/.config/containers/storage.conf':
    ensure  => 'file',
    source  => 'puppet:///modules/desktop/containers/storage.conf',
    owner   => 'asottile',
    group   => 'asottile',
    require => Package['fuse-overlayfs'],
  }
}
