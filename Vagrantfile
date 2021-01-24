# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	# Node R2 configuration
	config.vm.define "nfv1" do |nfv1|
		nfv1.vm.box = "srouting/srv6-net-prog"
		nfv1.vm.box_version = "0.4.14"
                nfv1.vm.synced_folder(".", nil, :disabled => true, :id => "vagrant-root")
		nfv1.vm.network "private_network", ip: "fc00::2", mac: "00154d000001",virtualbox__intnet: "net2"
		nfv1.vm.provider "virtualbox" do |virtualbox|
			virtualbox.memory = "512"
			virtualbox.cpus = "1"
			virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
			virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
		end
                nfv1.vm.provision "shell", path: "config/config_nfv1.sh"
	end

	# Node R2 configuration
	config.vm.define "nfv2" do |nfv2|
		nfv2.vm.box = "srouting/srv6-net-prog"
		nfv2.vm.box_version = "0.4.14"
                nfv2.vm.synced_folder(".", nil, :disabled => true, :id => "vagrant-root")
		nfv2.vm.network "private_network", ip: "fc00::3", mac: "00154d000002",virtualbox__intnet: "net2"
		nfv2.vm.provider "virtualbox" do |virtualbox|
			virtualbox.memory = "512"
			virtualbox.cpus = "1"
			virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
			virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
		end
                nfv2.vm.provision "shell", path: "config/config_nfv2.sh"
	end

end
