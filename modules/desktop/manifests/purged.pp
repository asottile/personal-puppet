class desktop::purged {
  $purged = [
    'command-not-found', 'gitk', 'libreoffice-common',
    'printer-driver-foo2zjs', 'snapd',
  ]
  package {$purged: ensure => 'purged'}
}
