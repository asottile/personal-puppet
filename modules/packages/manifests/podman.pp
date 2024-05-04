class packages::podman {
  package { ['buildah', 'podman', 'fuse-overlayfs'] : ensure => 'latest' }
}
