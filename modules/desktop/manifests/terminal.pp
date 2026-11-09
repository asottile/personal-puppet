class desktop::terminal {
  gsetting { 'org.gnome.Ptyxis restore-window-size':
    ensure => ':false',
    user   => 'asottile',
  }
  gsetting { 'org.gnome.Ptyxis default-rows':
    ensure => 41,
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
  gsetting { 'org.gnome.Ptyxis.Profile:/org/gnome/Ptyxis/Profiles/asottile/ limit-scrollback':
    ensure => ':false',
    user   => 'asottile'
  } ->
  gsetting { 'org.gnome.Ptyxis default-profile-uuid':
    ensure => 'asottile',
    user   => 'asottile'
  } ->
  gsetting { 'org.gnome.Ptyxis profile-uuids':
    ensure => ['asottile'],
    user   => 'asottile'
  }
}
