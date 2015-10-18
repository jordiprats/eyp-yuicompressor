# === Copyright
#
# Copyright 2015 Jordi Prats Catala
#
class yuicompressor (
                      $version='2.4.8',
                      $srcdir='/usr/local/src',
                      $basedir='/opt/yuicompressor',
                      $binfile='/usr/local/bin/yui') {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  exec { 'check java yuicompressor':
    command => 'update-alternatives --display java',
  }

  exec { "mkdir p yuicompressor basedir ${basedir}":
    command => "mkdir -p ${basedir}",
    creates => $basedir,
  }

  file { "${basedir}/yuicompressor-${version}.jar":
    ensure   => 'present',
    owner    => 'root',
    group    => 'root',
    mode     => '0640',
    source 	 => "puppet:///modules/${module_name}/yuicompressor-${version}.jar",
    require  => Exec["mkdir p yuicompressor basedir ${basedir}"],
  }

  file { $binfile:
    ensure => 'present',
    owner => 'root',
    group => 'root',
    mode => '0755',
    content => template("${module_name}/yui.erb"),
    require => [ File["${basedir}/yuicompressor-${version}.jar"], Exec['check java yuicompressor'] ]
  }
}
