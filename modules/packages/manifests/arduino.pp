class packages::arduino {
  $packages = ['arduino-core-avr', 'avr-libc', 'avrdude', 'gcc-avr']
  package { $packages : ensure => 'latest'}
}
