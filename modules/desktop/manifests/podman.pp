class desktop::podman {
  file { '/home/asottile/bin/docker':
    ensure  => 'link',
    target  => '/usr/bin/podman',
    owner   => 'asottile',
    group   => 'asottile',
    require => [Package['podman'], File['/home/asottile/bin']],
  }
}
