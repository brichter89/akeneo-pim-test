Exec { path => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ] }

import "apache.pp"
import "php.pp"
import "mysql.pp"
# import "oxid.pp"

package { 
    [
        'openjdk-7-jre',
        'git',
    ]:
}

file {
    "/etc/apache2/sites-available/akeneo-dev.conf":
        source => "/vagrant/config/files/etc/apache2/sites-available/akeneo-dev.conf",
        require => Package["apache2"],
        owner => "root",
        group => "root",
        notify => Service["apache2"],
        ;
    "/etc/php5/":
        source => "/vagrant/config/files/etc/php5/",
        recurse => true,
        owner => "root",
        group => "root",
        require => Package['php5'],
        notify => Service["apache2"],
        ;
    "/home/vagrant/":
        source => "/vagrant/config/files/home/vagrant/",
        recurse => true,
        owner => 'vagrant',
        group => 'vagrant',
        ;
    "/etc/profile.d/bash_aliases.sh":
        source => "/vagrant/config/files/etc/profile.d/bash_aliases.sh",
        owner => 'vagrant',
        group => 'vagrant',
        ;
}

exec { 'a2dissite 000-default.conf':
    onlyif => 'test -f /etc/apache2/sites-enabled/000-default.conf',
    require => Package['apache2'],
    notify => Service['apache2'],
}

exec { 'a2ensite akeneo-dev.conf':
    unless => 'test -f /etc/apache2/sites-enabled/akeneo-dev.conf',
    require => [
        Package['apache2'],
        File['/etc/apache2/sites-available/akeneo-dev.conf']
    ],
    notify => Service['apache2'],
}
