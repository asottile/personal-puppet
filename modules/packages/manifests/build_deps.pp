class packages::build_deps {
  $deps = [
    # git
    'libcurl4-openssl-dev', 'libssl-dev', 'zlib1g-dev',
    # cpython
    'libffi-dev', 'libreadline-dev', 'libsqlite3-dev',
    # oniguruma
    'libtool',
    # pyyaml
    'libyaml-dev',
    # pypy
    'pkg-config',
    # scss_lint
    'ruby-dev',
    # tmux
    'autoconf', 'bison', 'libevent-dev',
  ]
  package { $deps: ensure => 'latest' }
}
