class desktop::screensaver {
  gsetting { 'org.gnome.desktop.session idle-delay':
    ensure => 0,
    user   => 'asottile',
  }
}
