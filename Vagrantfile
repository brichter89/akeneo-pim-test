# -*- mode: ruby -*-
# vi: set ft=ruby :

dir = File.dirname(File.expand_path(__FILE__))

require 'yaml'
require "#{dir}/config/vagrant/functions.rb"

# Config file and template
cfgDistFile = "#{dir}/config/config.yaml.dist"
cfgFile     = "#{dir}/config/config.yaml"

# Load config
FileUtils.copy(cfgDistFile, cfgFile) if !File.exists?(cfgFile)
cfg = YAML.load_file(cfgFile)


Vagrant.configure("2") do |config|
    # Vars
    hostname = cfg['vm']['hostname']
    ssh_username = !cfg['ssh']['username'].nil? ? "#{cfg['ssh']['username']}" : "vagrant"

    # Box
    config.vm.box = "precise64"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    # Network
    config.vm.network :private_network, ip: "#{cfg['vm']['network']['private_network']}" if !cfg['vm']['network']['private_network'].nil?
    config.vm.network :public_network, :bridge => "#{cfg['vm']['network']['public_network']['bridge']}" if !cfg['vm']['network']['public_network']['bridge'].nil?

    # Hostname
    config.vm.hostname = "#{hostname}" if !hostname.nil?

    # Usable port range
    if (!cfg['vm']['network']['usable_port_range'].nil? && !cfg['vm']['network']['usable_port_range']['start'].nil? && !cfg['vm']['network']['usable_port_range']['end'].nil?)
        port_range = (cfg['vm']['network']['usable_port_range']['start']..cfg['vm']['network']['usable_port_range']['end'])
        config.vm.usable_port_range = port_range
    end

    # Forwarded ports
    if !cfg['vm']['network']['forwarded_port'].nil?
        cfg['vm']['network']['forwarded_port'].each do |port|
            if port['host'] != '' && port['guest'] != ''
                auto_correct = port['auto_correct'] || false
                config.vm.network :forwarded_port, host: port['host'], guest: port['guest'], auto_correct: auto_correct
            end
        end
    end

    # Synced folders
    if !cfg['vm']['synced_folder'].nil?
        cfg['vm']['synced_folder'].each do |folder|
            if folder['source'] != '' && folder['target'] != '' && folder['id'] != ''
                nfs = (folder['nfs'] == true && !Kernel.is_windows?) ? "nfs" : nil
                config.vm.synced_folder "#{folder['source']}", "#{folder['target']}", id: "#{folder['id']}", type: nfs
            end
        end
    end

    # Virtualbox settings
    config.vm.provider :virtualbox do |virtualbox|
        virtualbox.customize ["modifyvm", :id, "--name", "#{cfg['vm']['name']}"] if !cfg['vm']['name'].nil?
        virtualbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        virtualbox.customize ["modifyvm", :id, "--memory", cfg['vm']['memory']] if !cfg['vm']['memory'].nil?
        virtualbox.customize ["setextradata", :id, "--VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    end

    # Shell provisioning
    config.vm.provision :shell, :path => "config/shell/initial.sh"

    # Puppet provisioning
    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "config/puppet/manifests"
        puppet.facter = {
            "ssh_username" => "#{ssh_username}",
            "hostname" => "#{hostname}",
        }
        puppet.options = ["--pluginsync", "--summarize"]
    end

    # SSH config
    config.ssh.username = "#{ssh_username}"
    config.ssh.shell = "#{cfg['ssh']['shell']}" if !cfg['ssh']['shell'].nil?
    config.ssh.keep_alive = true
    config.ssh.forward_agent = false
    config.ssh.forward_x11 = false

    # Vagrant config
    config.vagrant.host = "#{cfg['vagrant']['host']}".gsub(":", "").intern if !cfg['vagrant']['host'].nil?
end

