class packages::docker {
  apt::key { '9DC858229FC7DD38854AE2D88D81803C0EBFCD88':
    ensure => 'absent',
    source => 'https://download.docker.com/linux/ubuntu/gpg',
  } ->
  apt::source { 'docker-ce':
    ensure       => 'absent',
    architecture => $::architecture,
    location     => 'https://download.docker.com/linux/ubuntu',
    repos        => 'stable',
    release      => $::lsbdistcodename,
  } ->
  package { 'docker-ce':
    ensure  => 'purged',
    require => Exec['apt_update'],
  }
}
