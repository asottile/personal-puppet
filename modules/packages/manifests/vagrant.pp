class packages::vagrant {
  package { 'vagrant':
    ensure   => '1:2.2.5',
    source   => 'https://releases.hashicorp.com/vagrant/2.2.5/vagrant_2.2.5_x86_64.deb#sha256=415f50b93235e761db284c761f6a8240a6ef6762ee3ec7ff869d2bccb1a1cdf7',
    provider => 'gdebi',
  }
}
