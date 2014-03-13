use_nfs = true
hostname = 'akeneo-dev'

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.network "private_network", ip: "192.168.55.10"

  config.vm.hostname = hostname


  config.vm.synced_folder "./akeneo", "/var/www/akeneo", :nfs => use_nfs

  config.vm.usable_port_range = (2200..2250)
  config.vm.provider :virtualbox do |virtualbox|
    virtualbox.customize ["modifyvm", :id, "--name", "akeneo-dev"]
    virtualbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    virtualbox.customize ["modifyvm", :id, "--memory", "1024"]
    virtualbox.customize ["setextradata", :id, "--VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

  # config.vm.provision :shell, :path => "config/shell/initial.sh"
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "config/puppet/manifests"
    puppet.facter = {
      "ssh_username" => "vagrant",
      "hostname" => hostname,
    }
    puppet.options = ["--pluginsync", "--summarize"]
  end

  config.ssh.username = "vagrant"

  config.ssh.shell = "bash -l"

  config.ssh.keep_alive = true
  config.ssh.forward_agent = false
  config.ssh.forward_x11 = false
  config.vagrant.host = :detect
end

