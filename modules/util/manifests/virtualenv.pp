define util::virtualenv(String $venv) {
  exec { "create ${venv}":
    command => join([
      "rm -rf ${venv} && ",
      'curl --silent --location --output /tmp/virtualenv.pyz https://bootstrap.pypa.io/virtualenv.pyz && ',
      "python3 /tmp/virtualenv.pyz ${venv} && ",
      'rm -rf /tmp/virtualenv.pyz',
    ]),
    unless  => join([
        "test -x ${venv}/bin/python && ",
        "info=\"$(${venv}/bin/python -S -c 'import sys;print(\".\".join(str(p) for p in sys.version_info))')\" && ",
        "grep \"^version_info = \$info$\" ${venv}/pyvenv.cfg",
    ]),
    user    => 'asottile',
    path    => '/usr/sbin:/usr/bin:/bin',
    require => [Package['curl'], File[dirname($venv)]],
  }
}
