class desktop::screensaver {
  gsetting { 'org.gnome.desktop.session idle-delay':
    ensure => 0,
    user   => 'asottile',
  }
  gsetting { 'org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type':
    ensure => 'nothing',
    user   => 'asottile',
  }
  gsetting { 'org.gnome.desktop.screensaver lock-enabled':
    ensure => ':false',
    user   => 'asottile',
  }
}
