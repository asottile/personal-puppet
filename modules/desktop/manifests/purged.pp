class desktop::purged {
  package { ['libreoffice-common', 'snapd']: ensure => purged }
}
