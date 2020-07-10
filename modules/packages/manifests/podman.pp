class packages::podman {
  apt::key { '2472D6D0D2F66AF87ABA8DA34D64390375060AA4':
    source => "https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${::lsbdistrelease}/Release.key",
  } ->
  apt::source { 'podman':
    location => "https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${::lsbdistrelease}/",
    release  => '',
    repos    => '/',
  } ->
  package { 'podman':
    ensure  => 'latest',
    require => Exec['apt_update'],
  }
}
