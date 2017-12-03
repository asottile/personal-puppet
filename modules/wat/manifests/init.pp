class wat {
  file {
    strip('/home/asottile/wat '):
      ensure => file,
      source => 'puppet:///modules/wat/wat',
      owner  => 'asottile',
      group  => 'asottile',
  }
}
