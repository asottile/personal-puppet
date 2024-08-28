class desktop {
  include desktop::arduino
  include desktop::background
  include desktop::dotfiles
  include desktop::go
  include desktop::homedir
  include desktop::keyboard
  include desktop::launcher
  include desktop::node
  include desktop::packer
  include desktop::pidgin
  include desktop::podman
  include desktop::purged
  include desktop::pypy
  include desktop::screensaver
  include desktop::sshd
  include desktop::terraform
  include desktop::touchpad
  include desktop::venv
  include desktop::virtualbox
  include desktop::wayland
  include desktop::workspace

  include packages::debian_packaging
  include packages::build_deps
  include packages::editors
  include packages::firefox
  include packages::gnome_terminal
  include packages::podman
  include packages::python
  include packages::utilities

  if ! $facts['is_virtual'] {
    include packages::vlc
    include packages::virtualbox
  }
}
