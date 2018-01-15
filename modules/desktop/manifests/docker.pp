class desktop::docker {
  include packages::docker

  exec { 'add asottile to docker group':
    command => 'usermod --append --groups docker asottile',
    unless  => join([
        'id --name --groups --zero asottile | ',
        'grep --quiet --null-data --line-regexp docker',
    ]),
    path    => '/usr/sbin:/usr/bin:/bin',
    require => Package['docker-ce'],
  }
}
