class packages::utilities {
  package { ['jq', 'tree']: ensure => 'latest' }
}
