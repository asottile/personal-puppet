class packages::build_deps {
  $deps = [
    # git
    'libcurl4-openssl-dev', 'libssl-dev', 'zlib1g-dev',
    # cpython
    'libffi-dev',
    'libreadline-dev',
    'libsqlite3-dev',
    # pyyaml
    'libyaml-dev',
    # pypy
    'pkg-config',
    # scss_lint
    'ruby-dev',
  ]
  package { $deps: ensure => 'latest' }
}
