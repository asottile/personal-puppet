class desktop::touchpad {
  file { '/etc/X11/xorg.conf.d': ensure => 'directory' } ->
  file { '/etc/X11/xorg.conf.d/99-synaptics.conf':
    source => 'puppet:///modules/desktop/xorg/99-synaptics.conf'
  }

  gsetting { 'org.gnome.desktop.peripherals.touchpad natural-scroll':
    ensure => ':false',
    user   => 'asottile',
  }
}
