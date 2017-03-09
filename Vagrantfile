# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    config.vm.provider "virtualbox" do |v|
        v.memory = 2024
        v.cpus   = 2
    end

    config.vm.box = "ubuntu/xenial64"

    config.vm.provision "chef_solo" do |chef|
        chef.add_recipe "keepalived"
        chef.add_recipe "nginx"
    end

    config.vm.define "master", primary: true do |n|
        n.vm.network "private_network", ip: "192.168.3.10"
        n.vm.hostname = "master"
    end

    config.vm.define "slave1" do |n|
        n.vm.network "private_network", ip: "192.168.3.11"
        n.vm.hostname = "slave1"
    end

    config.vm.define "slave2" do |n|
        n.vm.network "private_network", ip: "192.168.3.12"
        n.vm.hostname = "slave2"
    end
end
