class desktop {
  include desktop::apple_touchpad
  include desktop::background
  include desktop::docker
  include desktop::dotfiles
  include desktop::go
  include desktop::homedir
  include desktop::launcher
  include desktop::pidgin
  include desktop::purged
  include desktop::pypy
  include desktop::screensaver
  include desktop::venv
  include desktop::virtualbox
  include desktop::workspace

  include packages::debian_packaging
  include packages::build_deps
  include packages::editors
  include packages::node
  include packages::python
  include packages::utilities

  if ! $::is_virtual {
    include packages::vlc
    include packages::vagrant
    include packages::virtualbox
  }
}
