class desktop::purged {
  $purged = ['libreoffice-common', 'printer-driver-foo2zjs', 'snapd']
  package {$purged: ensure => purged}
}
