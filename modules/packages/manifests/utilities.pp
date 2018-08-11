class packages::utilities {
  package { ['curl', 'inotify-tools', 'jq', 'tree']: ensure => 'latest' }
}
