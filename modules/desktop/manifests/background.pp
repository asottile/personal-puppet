class desktop::background {
  $bg = 'file:///usr/share/backgrounds/Twilight_Frost_by_Phil_Jackson.jpg'

  package { 'ubuntu-wallpapers-precise': ensure => 'present' } ->
  gsetting { 'org.gnome.desktop.background picture-uri':
    ensure => $bg,
    user   => 'asottile',
  } ->
  gsetting { 'org.gnome.desktop.screensaver picture-uri':
    ensure => $bg,
    user   => 'asottile',
  }
}
