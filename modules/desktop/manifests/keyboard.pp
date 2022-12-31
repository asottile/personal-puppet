class desktop::keyboard {
  gsetting { 'org.gnome.desktop.input-sources xkb-options':
    ensure => ['caps:none'],
    user   => 'asottile',
  }
}
