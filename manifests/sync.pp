define lsyncd::sync(
	$synctype 	= "default.rsyncssh",
	$source	 	= undef,
	$host		= undef,
	$targetdir	= undef,
	$delay		= "0",
	$exclude    	= [],
	$rsync		= {},
)
{
  concat::fragment{ $name:
    target  => '/etc/lsyncd.conf',
    content => template('lsyncd/conf/sync.erb'),
    order   => '100',
  }
}
