Akaneo PIM Test
===============

Environment to try out Akeneo PIM on a Vagrant VM



## Requirements
- [Vagrant](http://vagrantup.com/)
- [VirtualBox](https://virtualbox.org/)



## Installation
Clone repo (or fork and then clone yours):

    $ git clone https://github.com/brichter89/akeneo-pim-test.git

Copy `<project>/config/config.yaml.dist` to `<project>/config/config.yaml` and change config values as needed in `config.yaml`. Change hostname to something unique to use it via DHCP. If you want to leave standard configuration just ignore this step. Vagrant will automatically create a local copy of `config.yaml.dist`

Power on VM:

    $ vagrant up

this powers on the VM and starts initial provisioning.

While you're waiting, download [the Akeneo PIM zip file](http://www.akeneo.com/download/) and extract the contents of `pim-community-standard-vX.X.X-XXX/` to the `akeneo` dir in your project.

When provisioning is done you can ssh into the VM with

    $ vagrant ssh

and install akeneo:

    $ akeneo-install

(this might take about 30 minutes)



## Connect to your PIM application
Go to http://192.168.55.10/ and login with
or - if your DHCP supports this - use http://<hostname>/ (the hostname you have set in your `config.yaml`)

- **username:** admin
- **password:** admin



## Weblinks
- [Akeneo Home](http://akeneo.com/)
- [Akeneo GitHub](https://github.com/akeneo/pim-community-standard) - Pim Community Standard Repository
