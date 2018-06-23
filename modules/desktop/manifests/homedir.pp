class desktop::homedir {
  file { [
    '/home/asottile/Documents',
    '/home/asottile/Pictures',
    '/home/asottile/Public',
    '/home/asottile/Templates',
    '/home/asottile/Videos',
  ]:
    ensure  => 'absent',
    recurse => true,
    force   => true,
  }

  file { '/home/asottile/bin':
    ensure => 'directory',
    owner  => 'asottile',
    group  => 'asottile',
  }
}
