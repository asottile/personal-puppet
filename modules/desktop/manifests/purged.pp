class desktop::purged {
  $purged = ['gitk', 'libreoffice-common', 'printer-driver-foo2zjs', 'snapd']
  package {$purged: ensure => purged}
}
