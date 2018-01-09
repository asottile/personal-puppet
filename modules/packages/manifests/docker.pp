class packages::docker {
  apt::key { '9DC858229FC7DD38854AE2D88D81803C0EBFCD88':
    source => 'https://download.docker.com/linux/ubuntu/gpg',
  } ->
  apt::source { 'docker-ce':
    architecture => 'amd64',
    location     => 'https://download.docker.com/linux/ubuntu',
    release      => "${::lsbdistcodename} stable",
  } ->
  package { 'docker-ce':
    ensure  => 'latest',
    require => Exec['apt_update'],
  }
}
