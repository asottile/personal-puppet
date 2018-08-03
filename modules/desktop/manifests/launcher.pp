class desktop::launcher {
  gsetting { 'org.gnome.shell favorite-apps':
    ensure  => [
      'org.gnome.Nautilus.desktop',
      'org.gnome.Terminal.desktop',
      'firefox.desktop',
      'pidgin.desktop',
      'gnome-control-center.desktop',
    ],
    user    => 'asottile',
    require => [Package['pidgin']],
  }
  gsetting { 'org.gnome.shell.extensions.dash-to-dock multi-monitor':
    ensure => ':true',
    user   => 'asottile',
  }
}
