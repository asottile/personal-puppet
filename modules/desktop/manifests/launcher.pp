class desktop::launcher {
  gsetting { 'com.canonical.Unity.Launcher favorites':
    ensure => [
      'application://org.gnome.Nautilus.desktop',
      'application://gnome-terminal.desktop',
      'application://firefox.desktop',
      'application://unity-control-center.desktop',
      # built in unity things
      'unity://running-apps', 'unity://expo-icon', 'unity://devices',
    ],
    user   => 'asottile',
  }
}
