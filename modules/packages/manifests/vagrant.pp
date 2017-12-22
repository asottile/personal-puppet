class packages::vagrant {
  package { 'vagrant':
    ensure           => '1:2.0.1',
    source           => 'https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.deb',
    package_settings => {
      sha256 => '2f9498a83b3d650fcfcfe0ec7971070fcd3803fad6470cf7da871caf2564d84f',
    },
    provider         => 'gdebi',
  }
}
