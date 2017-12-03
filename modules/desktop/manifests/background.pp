class desktop::background {
  $schema = 'org.gnome.desktop.background'
  $key = 'picture-uri'
  $bg = 'file:///usr/share/backgrounds/Twilight_Frost_by_Phil_Jackson.jpg'

  package { 'ubuntu-wallpapers-precise': ensure => 'present' } ->
  exec { 'set desktop background':
    command => "bash -euxc '
      # DBUS_SESSION_BUS_ADDRESS is needed to update immediately
      envvar=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u asottile gnome-session)/environ);
      env \$envvar gsettings set ${schema} ${key} ${bg}
    '",
    unless  => "test $(gsettings get ${schema} ${key} | sed \"s/'//g\") = ${bg}",
    user    => 'asottile',
    path    => '/bin:/usr/bin',
  }
}
