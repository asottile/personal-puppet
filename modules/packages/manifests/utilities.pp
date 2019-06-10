class packages::utilities {
  $tools = [
    'curl', 'dos2unix', 'graphviz', 'inotify-tools', 'jq', 'sqlite3', 'tmux',
    'tree',
  ]
  package { $tools: ensure => 'latest' }
}
