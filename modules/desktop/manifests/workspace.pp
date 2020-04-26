class desktop::workspace {
  $repos = [
    'python/cpython',
    'asottile/all-repos', 'asottile/babi', 'asottile/pyupgrade',
    'pre-commit/pre-commit', 'pre-commit/pre-commit-hooks',
  ]

  $repos.each |$repo| {
    $name = basename($repo)
    vcsrepo { "/home/asottile/workspace/${name}":
      ensure   => 'present',
      user     => 'asottile',
      provider => 'git',
      source   => "git@github.com:${repo}",
    }
  }

  file { '/home/asottile/workspace/deadsnakes':
    ensure => 'directory',
    owner  => 'asottile',
    group  => 'asottile',
  } ->
  vcsrepo { '/home/asottile/workspace/deadsnakes/runbooks':
    ensure   => 'present',
    user     => 'asottile',
    provider => 'git',
    source   => 'git@github.com:deadsnakes/runbooks',
  }

  $awc_repos = ['thumbnails', 'twitch-chat-bot']
  file { '/home/asottile/workspace/anthonywritescode':
    ensure => 'directory',
    owner  => 'asottile',
    group  => 'asottile',
  }
  $awc_repos.each |$awc_repo| {
    vcsrepo { "/home/asottile/workspace/anthonywritescode/${awc_repo}":
      ensure   => 'present',
      user     => 'asottile',
      provider => 'git',
      source   => "git@github.com:anthonywritescode/${awc_repo}",
      require  => File['/home/asottile/workspace/anthonywritescode'],
    }
  }
}
