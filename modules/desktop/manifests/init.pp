class desktop {
  include desktop::background
  include desktop::launcher
  include desktop::pidgin

  include packages::debian_packaging
  include packages::python

  if ! $::is_virtual {
    include packages::vagrant
    include packages::virtualbox
  }
}
