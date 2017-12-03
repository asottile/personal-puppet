class common::vagrant {
  $version = '1:2.0.1'
  $url = 'https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.deb'
  $sha256 = '2f9498a83b3d650fcfcfe0ec7971070fcd3803fad6470cf7da871caf2564d84f'
  $tmppath = '/tmp/vagrant.deb'

  exec { 'install vagrant':
    command => "bash -euxc '
        cleanup() {
            rm -f ${tmppath}
        }
        cleanup
        trap cleanup EXIT
        wget --quiet --output-document ${tmppath} ${url}
        echo ${sha256} ${tmppath} | sha256sum --check
        gdebi --non-interactive ${tmppath}
    '",
    unless  => "test \"$(dpkg-query --show --showformat=\"\${Version}\" vagrant)\" != ${version}",
    path    => '/usr/sbin:/usr/bin:/sbin:/bin',
    require => Package['gdebi-core'],
  }
}
