class desktop {
  include desktop::background
  include desktop::launcher
  include desktop::pidgin

  include packages::debian_packaging
  include packages::python
  include packages::utilities

  if ! $::is_virtual {
    include packages::vagrant
    include packages::virtualbox
  }
}
