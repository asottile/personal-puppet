class packages::gnome_terminal {
  # TODO: make a ppa? I had to disable the extension due to lockstep upgrade
  package { 'nautilus-extension-gnome-terminal': ensure => 'purged' } ->
  package { 'gnome-terminal-data':
    ensure   => '3.36.2-1ubuntu1~20.04+asottile1',
    source   => 'https://github.com/asottile/gnome-terminal-broken/releases/download/3.36.2-1ubuntu1_20.04%2Basottile1/gnome-terminal-data_3.36.2-1ubuntu1.20.04+asottile1_all.deb#sha256=e2c3ca3483d882ad7c1a2eee85d41882211f9a2fad789e755fa47374cf729f13',
    provider => 'gdebi',
  } ->
  package { 'gnome-terminal':
    ensure   => '3.36.2-1ubuntu1~20.04+asottile1',
    source   => 'https://github.com/asottile/gnome-terminal-broken/releases/download/3.36.2-1ubuntu1_20.04%2Basottile1/gnome-terminal_3.36.2-1ubuntu1.20.04+asottile1_amd64.deb#sha256=d69cef129e75f9d4f2cf754e00139e22297bfe97104aca53f18d6ce5d960daff',
    provider => 'gdebi',
  }
}
