class desktop {
  include desktop::background

  if ! $::is_virtual {
    include packages::vagrant
    include packages::virtualbox
  }
}
