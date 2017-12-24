class packages::debian_packaging {
  package {'aptitude': ensure => 'latest' }
  package {'devscripts': ensure => 'latest' }
}
