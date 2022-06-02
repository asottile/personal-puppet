class packages::gnome_terminal {
  apt::ppa { 'ppa:asottile/gnome-terminal-tab-tearing': } ->
  package { ['gnome-terminal', 'gnome-terminal-data']: ensure => 'latest' }
}
