class packages::utilities {
  $tools = [
    'curl', 'dos2unix', 'graphviz', 'inotify-tools', 'jq', 'mlocate',
    'net-tools', 'rlwrap', 'sqlite3', 'tmux', 'tree',
  ]
  package { $tools: ensure => 'latest' }
}
