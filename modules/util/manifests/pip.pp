define util::pip(String $pkg, String $venv) {
  $pkg_re = regsubst($pkg, '-', '[-_]')
  exec { "pip install ${pkg} into ${venv}":
    command => "${venv}/bin/pip install ${pkg}",
    unless  => "${venv}/bin/pip freeze | grep '^${pkg_re}=='",
    user    => 'asottile',
  }
}
