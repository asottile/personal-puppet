class desktop::docker {
  include packages::docker

  exec { 'remove asottile from docker group':
    command => 'gpasswd --delete asottile docker',
    onlyif  => join([
        'id --name --groups --zero asottile | ',
        'grep --quiet --null-data --line-regexp docker',
    ]),
    path    => '/usr/sbin:/usr/bin:/bin',
    require => Package['docker-ce'],
  }

  file { '/home/asottile/bin/docker':
    ensure  => 'link',
    target  => '/usr/bin/podman',
    owner   => 'asottile',
    group   => 'asottile',
    require => [Package['podman'], File['/home/asottile/bin']],
  }
}
