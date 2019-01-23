class packages::build_deps {
  $deps = [
    # git
    'libcurl4-openssl-dev', 'libssl-dev', 'zlib1g-dev',
    # cpython
    'libffi-dev',
    'libreadline-dev',
    # pyyaml
    'libyaml-dev',
    # scss_lint
    'ruby-dev',
  ]
  package { $deps: ensure => 'latest' }
}
