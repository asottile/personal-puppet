class desktop::terminal {
  gsetting { 'org.gnome.Ptyxis restore-window-size':
    ensure => ':false',
    user   => 'asottile',
  }
  gsetting { 'org.gnome.Ptyxis default-rows':
    ensure => 40,
    user   => 'asottile',
  }
  gsetting { 'org.gnome.Ptyxis use-system-font':
    ensure => ':false',
    user   => 'asottile',
  }
  gsetting { 'org.gnome.Ptyxis font-name':
    ensure => 'Monospace 13.5',
    user   => 'asottile',
  }
}
