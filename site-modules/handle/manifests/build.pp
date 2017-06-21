# Build the Handle Server Docker image
class handle::build {
  $docker_build_dir = lookup('docker_build_dir', String)
  $handle_build_dir = "${docker_build_dir}/handle"

  file { $handle_build_dir:
    ensure => directory,
  }

  file { "${handle_build_dir}/Dockerfile":
    content => epp('handle/Dockerfile.handle.epp',
      {
        'handle_download_url' => lookup('handle::download_url'),
      }
    ),
    notify  => Docker::Image['rpid-handle'],
  }

  docker::image { 'rpid-handle':
    ensure     => latest,
    docker_dir => $handle_build_dir,
  }
}
