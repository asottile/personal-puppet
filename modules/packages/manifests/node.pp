class packages::node {
  package { ['nodejs', 'npm']: ensure => 'latest' }
}
