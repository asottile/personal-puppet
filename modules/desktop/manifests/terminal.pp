class desktop::terminal {
  gsetting { 'org.gnome.Ptyxis restore-window-size':
    ensure => ':false',
    user   => 'asottile',
  }
  gsetting { 'org.gnome.Ptyxis default-rows':
    ensure => 30,
    user   => 'asottile',
  }
}
