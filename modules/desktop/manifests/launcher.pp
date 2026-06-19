class desktop::launcher {
  gsetting { 'org.gnome.shell favorite-apps':
    ensure => [
      'org.gnome.Nautilus.desktop',
      'org.gnome.Ptyxis.desktop',
      'firefox.desktop',
      'org.gnome.Settings.desktop',
    ],
    user   => 'asottile',
  }
  gsetting { 'org.gnome.shell.extensions.dash-to-dock multi-monitor':
    ensure => ':true',
    user   => 'asottile',
  }
  gsetting { 'org.gnome.shell.extensions.dash-to-dock dock-position':
    ensure => 'RIGHT',
    user   => 'asottile',
  }
  gsetting { 'org.gnome.shell.extensions.dash-to-dock show-mounts':
    ensure => ':false',
    user   => 'asottile',
  }
  gsetting { 'org.gnome.shell.extensions.ding show-home':
    ensure => ':false',
    user   => 'asottile',
  }
}
