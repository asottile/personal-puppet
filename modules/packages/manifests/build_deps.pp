class packages::build_deps {
  $deps = [
    # git
    'libcurl4-openssl-dev', 'libssl-dev', 'zlib1g-dev',
    # pyyaml
    'libyaml-dev',
  ]
  package { $deps: ensure => 'latest' }
}
