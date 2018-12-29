class desktop::apple_touchpad {
  file { '/etc/X11/xorg.conf.d': ensure => 'directory' } ->
  file { '/etc/X11/xorg.conf.d/99-synaptics.conf':
    source => 'puppet:///modules/desktop/xorg/99-synaptics.conf'
  }
}
