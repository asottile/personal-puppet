class desktop::screensaver {
  gsetting { 'org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type':
    ensure => 'nothing',
    user   => 'asottile',
  }
  gsetting { 'org.gnome.desktop.session idle-delay':
    ensure => 0,
    user   => 'asottile',
  }
}
