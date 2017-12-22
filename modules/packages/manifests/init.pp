class packages {
  require ::apt
  package { 'gdebi-core': ensure => 'latest' }
}
