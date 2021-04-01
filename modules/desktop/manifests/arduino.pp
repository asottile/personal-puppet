class desktop::arduino {
  include packages::arduino

  exec { 'add asottile to dialout group':
    command => 'usermod --append --groups dialout asottile',
    unless  => join([
        'id --name --groups --zero asottile | ',
        'grep --quiet --null-data --line-regexp dialout',
    ]),
    path    => '/usr/sbin:/usr/bin:/bin',
  }
}
