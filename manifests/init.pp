# Class: lsyncd
#

class lsyncd (

  $config_source  = $::lsyncd::params::config_source,
  $config_content = $::lsyncd::params::config_content,
  $lsyncd_options = $::lsyncd::params::lsyncd_options,
  $lsyncd_user    = $::lsyncd::params::lsyncd_user,
  $nodaemon       = $::lsyncd::params::nodaemon,
  $maxdelays      = $::lsyncd::params::maxdelays,
  $maxprocesses   = $::lsyncd::params::maxprocesses,
  $insist         = $::lsyncd::params::insist,

) inherits lsyncd::params {

  package { 'lsyncd': ensure => 'installed' }

  file { '/etc/init.d/lsyncd':
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("lsyncd/lsyncd-init.erb"),
    require => Package['lsyncd'],
    notify  => Service['lsyncd'],
  }

  service { 'lsyncd':
    ensure    => 'running',
    enable    => true,
    hasstatus => true,
    require   => Package['lsyncd'],
  }

  concat { '/etc/lsyncd.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    path    => '/etc/lsyncd.conf',
    require => Package['lsyncd'],
    notify  => Service['lsyncd'],
  }

  concat::fragment { 'lsyncd global settings':
    target  => '/etc/lsyncd.conf',
    content => template('lsyncd/lsyncd-conf.erb'),
    order   => '01',
  }

  file { '/etc/sysconfig/lsyncd':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("lsyncd/lsyncd-sysconfig.erb"),
    require => Package['lsyncd'],
    notify  => Service['lsyncd'],
  }

  # As of 2.1.4-3.el6 the rpm package doesn't include these directories
  # Later versions do, but we might need to change permissions
  file { [ $logdir, $pid_dir ]:
    ensure  => 'directory',
    owner   => $lsyncd_user,
    group   => $lsyncd_user,
    mode    => $logdir_mode,
    require => Package['lsyncd'],
    before  => Service['lsyncd'],
  }

}
