class desktop::virtualbox {
  if $::is_virtual and $::virtual == 'virtualbox' {
    exec { 'add asottile to vboxsf group':
      command => 'usermod --append --groups vboxsf asottile',
      unless  => join([
          'id --name --groups --zero asottile | ',
          'grep --quiet --null-data --line-regexp vboxsf',
      ]),
      path    => '/usr/sbin:/usr/bin:/bin',
    }
  }
}
