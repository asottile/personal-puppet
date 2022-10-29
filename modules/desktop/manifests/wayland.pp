class desktop::wayland {
  file { '/etc/gdm3/custom.conf':
    ensure  => 'file',
    content => "[daemon]\nWaylandEnable=false\n",
    mode    => '0644',
  }
}
