class desktop::sshd {
  # if I install sshd, don't accidentally enable password auth
  file { ['/etc/ssh', '/etc/ssh/sshd_config.d']: ensure => 'directory' } ->
  file { '/etc/ssh/sshd_config.d/no-password-auth.conf':
    ensure  => 'file',
    content => 'PasswordAuthentication no',
    mode    => '0644',
  }
}
