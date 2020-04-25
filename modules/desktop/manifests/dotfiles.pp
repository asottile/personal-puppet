class desktop::dotfiles {
  $dotfiles = [
    '.bashrc', '.bash_aliases', '.config/babi/theme.json', '.gitconfig',
    '.hgrc', '.nanorc', '.pypirc', '.pythonrc.py', '.tmux.conf',
  ]
  $binfiles = [
    'bash/git-happy-merge', 'python/git-github-compare',
    'python/git-github-fork', 'python/git-github-url',
    'python/inotify-exec', 'python/prune-remote-branches.py',
  ]

  vcsrepo { '/home/asottile/workspace/scratch':
    ensure   => 'present',
    user     => 'asottile',
    provider => 'git',
    source   => 'git@github.com:asottile/scratch',
  }

  $dotfiles.each |$f| {
    file { "/home/asottile/${f}":
      ensure  => 'link',
      target  => "/home/asottile/workspace/scratch/${f}",
      owner   => 'asottile',
      group   => 'asottile',
      require => Vcsrepo['/home/asottile/workspace/scratch'],
    }
  }

  # previous dotfiles, removed
  file { ['/home/asottile/.pdbrc', '/home/asottile/nanorc']:
    ensure => 'absent'
  }

  $binfiles.each |$f| {
    file { "/home/asottile/bin/${basename($f)}":
      ensure  => 'link',
      target  => "/home/asottile/workspace/scratch/${f}",
      owner   => 'asottile',
      group   => 'asottile',
      require => [
        Vcsrepo['/home/asottile/workspace/scratch'],
        File['/home/asottile/bin'],
      ],
    }
  }

  # many scripts use this, though we can't set contents quite yet
  file { '/home/asottile/.github-auth.json':
    ensure => 'present',
    owner  => 'asottile',
    group  => 'asottile',
    mode   => '0600',
  }
}
