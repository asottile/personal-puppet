class packages::utilities {
  $tools = [
    'curl', 'dos2unix', 'ffmpeg', 'graphviz', 'inotify-tools', 'jq', 'ncdu',
    'neofetch', 'net-tools', 'plocate', 'rlwrap', 'sqlite3', 'tmux', 'tree',
    'xclip',
  ]
  package { $tools: ensure => 'latest' }
}
