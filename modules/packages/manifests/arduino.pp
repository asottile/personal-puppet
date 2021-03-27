class packages::arduino {
  package { ['avr-libc', 'avrdude', 'gcc-avr']: ensure => 'latest'}
}
