class packages::utilities {
  $tools = ['curl', 'dos2unix', 'inotify-tools', 'jq', 'tree']
  package { $tools: ensure => 'latest' }
}
