class packages::utilities {
  $tools = [
    'curl', 'dos2unix', 'graphviz', 'inotify-tools', 'jq', 'sqlite3', 'tree',
  ]
  package { $tools: ensure => 'latest' }
}
