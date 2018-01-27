node default {
  require ::apt
  require ::gdebi

  include desktop
}
