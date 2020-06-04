class packages::gnome_terminal {
  # TODO: make a ppa? I had to disable the extension due to lockstep upgrade
  package { 'nautilus-extension-gnome-terminal': ensure => 'purged' } ->
  package { 'gnome-terminal-data':
    ensure   => '3.36.1.1-1ubuntu1+asottile1',
    source   => 'https://github.com/asottile/gnome-terminal-broken/releases/download/3.36.1.1-1ubuntu1%2Basottile1/gnome-terminal-data_3.36.1.1-1ubuntu1+asottile1_all.deb#sha256=fc9c060c637d295163e2a94c9449ea5708ae4a2efcdf7d6043bdb272a2bc5d3e',
    provider => 'gdebi',
  } ->
  package { 'gnome-terminal':
    ensure   => '3.36.1.1-1ubuntu1+asottile1',
    source   => 'https://github.com/asottile/gnome-terminal-broken/releases/download/3.36.1.1-1ubuntu1%2Basottile1/gnome-terminal_3.36.1.1-1ubuntu1+asottile1_amd64.deb#sha256=04967beb6268775607406b5e2f8212a40afe4042c133ba063622c5b8f66a2de7',
    provider => 'gdebi',
  }
}
