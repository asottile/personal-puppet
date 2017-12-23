class desktop::background {
  $schema = 'org.gnome.desktop.background'
  $key = 'picture-uri'
  $bg = 'file:///usr/share/backgrounds/Twilight_Frost_by_Phil_Jackson.jpg'

  package { 'ubuntu-wallpapers-precise': ensure => 'present' } ->
  gsetting { 'org.gnome.desktop.background picture-uri':
    ensure => 'file:///usr/share/backgrounds/Twilight_Frost_by_Phil_Jackson.jpg',
    user   => 'asottile',
  }
}
