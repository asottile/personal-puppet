class desktop {
  include desktop::background
  include desktop::docker
  include desktop::dotfiles
  include desktop::homedir
  include desktop::launcher
  include desktop::pidgin
  include desktop::screensaver
  include desktop::venv

  include packages::debian_packaging
  include packages::build_deps
  include packages::editors
  include packages::node
  include packages::python
  include packages::utilities

  if ! $::is_virtual {
    include packages::vagrant
    include packages::virtualbox
  }
}
