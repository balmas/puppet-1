# Run the Handle Server container
class handle::server {
  $docker_run_dir = lookup('docker_run_dir', String)
  $handle_run_dir = "${docker_run_dir}/handle"

  file { $handle_run_dir:
    ensure => directory,
  }
  
  file { "${handle_run_dir}/config.dct":
    content => epp('handle/config.dct.epp', hiera('handle::config')),
  }
    
  docker::run { 'rpid-handle':
    image   => 'rpid-handle',
    volumes => ["${handle_run_dir}:/srv/hs1/svr1"],
  }
}
