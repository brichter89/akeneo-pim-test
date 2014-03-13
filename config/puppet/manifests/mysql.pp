package { "mysql-client": }
package { "mysql-server": }
package { "mysql-common": }

service {"mysql":
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Package["mysql-server"]
}

# exec { 'Create akeneo database and user':
#     command => "mysql -u root -e ''",
#     require => [ Package['mysql-server'], Package['mysql-client'], Package['mysql-common'], ],
# }