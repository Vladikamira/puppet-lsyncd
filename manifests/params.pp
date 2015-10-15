class lsyncd::params {

	if $::osfamily == 'RedHat' {
		$config_source  = undef
  		$config_content = undef
		$lsyncd_user    = 'root'
		$lsyncd_options = undef
  		$logdir_owner   = $lsyncd_user
  		$logdir_group   = $lsyncd_user
  		$logdir_mode    = '0755'
		$logdir		= "/var/log/lsyncd"
        	$logfile 	= "${logdir}/lsyncd.log"
        	$statusfile 	= "${logdir}/lsyncd-status.log"
		$pid_dir	= "/var/run/lsyncd"
		$pidfile	= "${pid_dir}/lsyncd.pid"
        	$statusinterval = 30
        	$nodaemon 	= false
        	$maxdelays 	= 10
        	$maxprocesses 	= 12
        	$insist 	= true

	} else { 
		fail("Class['lsyncd::params']: Unsupported osfamily: ${::osfamily}")
	}

}
