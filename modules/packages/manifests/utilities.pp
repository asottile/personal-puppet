class packages::utilities {
  $tools = [
    'curl', 'dos2unix', 'ffmpeg', 'graphviz', 'inotify-tools', 'jq', 'mlocate',
    'ncdu', 'neofetch', 'net-tools', 'rlwrap', 'sqlite3', 'tmux', 'tree',
    'xclip',
  ]
  package { $tools: ensure => 'latest' }
}
