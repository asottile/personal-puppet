class packages::virtualbox {
  apt::key { 'B9F8D658297AF3EFC18D5CDFA2F683C52980AECF':
    source => 'https://www.virtualbox.org/download/oracle_vbox_2016.asc',
  } ->
  apt::source { 'virtualbox':
    location     => 'http://download.virtualbox.org/virtualbox/debian',
    release      => $::lsbdistcodename,
    architecture => $::architecture,
    repos        => 'contrib',
  } ->
  package { 'virtualbox-5.2':
    ensure  => 'latest',
    require => Exec['apt_update'],
  }
}
