class common::apt {
  include ::apt
  package { 'gdebi-core': ensure => 'latest' }
}
