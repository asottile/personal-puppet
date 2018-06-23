class packages::utilities {
  package { ['curl', 'jq', 'tree']: ensure => 'latest' }
}
