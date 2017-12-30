class desktop::pidgin {
  package { 'pidgin': ensure => 'latest' } ->
  file { '/home/asottile/.purple':
    ensure => 'directory',
    owner  => 'asottile',
    group  => 'asottile',
    mode   => '0700',
  } ->
  file {
    default:
      owner => 'asottile',
      group => 'asottile',
      mode  => '0600';

    '/home/asottile/.purple/accounts.xml':
      source => 'puppet:///modules/desktop/pidgin/accounts.xml';

    '/home/asottile/.purple/blist.xml':
      source => 'puppet:///modules/desktop/pidgin/blist.xml';
  }
}
