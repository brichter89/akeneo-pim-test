Akaneo PIM Test
===============

Environment to try out Akeneo PIM on a Vagrant VM



## Requirements
- [Vagrant](http://vagrantup.com/)
- [VirtualBox](https://virtualbox.org/)



## Installation
Clone repo (or fork and then clone yours):

    $ git clone https://github.com/brichter89/akeneo-pim-test.git


Power on VM:

    $ vagrant up

this powers on the VM and starts initial provisioning.

After that, connect to VM:

    $ vagrant ssh

You now can either

- install dependencies with composer (might be slower):

        $ cd /var/www/akeneo
        $ composer install

- or (might be faster) download [the zip file](http://www.akeneo.com/download/) and extract contents of `pim-community-standard-vX.X.X-XXX/` to the `akeneo` dir in your project (just overwrite all files)

Now you can install Akeneo PIM:

    $ akeneo-install

(this might take about 30 minutes)



## Connect to your PIM application
Go to http://192.168.55.10/ and login with

- **username:** admin
- **password:** admin



## Weblinks
- [Akeneo Home](http://akeneo.com/)
- [Akeneo GitHub](https://github.com/akeneo/pim-community-standard) - Pim Community Standard Repository
