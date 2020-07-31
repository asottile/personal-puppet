define util::pip(String $pkg, String $venv) {
  exec { "pip install ${pkg} into ${venv}":
    command => "${venv}/bin/pip install ${pkg}",
    unless  => "${venv}/bin/pip freeze | grep '^${pkg}=='",
    user    => 'asottile',
  }
}
