class packages::docker {
  apt::key { '9DC858229FC7DD38854AE2D88D81803C0EBFCD88':
    source => 'https://download.docker.com/linux/ubuntu/gpg',
  } ->
  apt::source { 'docker-ce':
    architecture => $::architecture,
    location     => 'https://download.docker.com/linux/ubuntu',
    # TODO: switch to stable when released in bionic
    repos        => 'edge',
    release      => $::lsbdistcodename,
  } ->
  package { 'docker-ce':
    ensure  => 'latest',
    require => Exec['apt_update'],
  }
}
