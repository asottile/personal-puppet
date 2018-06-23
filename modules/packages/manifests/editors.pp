class packages::editors {
  package { ['nano', 'vim-nox']: ensure => 'latest' }
}
