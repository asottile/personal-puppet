class desktop {
  include desktop::background
  include desktop::launcher
  include desktop::pidgin

  if ! $::is_virtual {
    include packages::vagrant
    include packages::virtualbox
  }
}
