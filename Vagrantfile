# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	# Node RAN configuration
	config.vm.define "ran" do |ran|
		ran.vm.box = "srouting/srv6-net-prog"
		ran.vm.box_version = "0.4.14"
                ran.vm.synced_folder(".", nil, :disabled => true, :id => "vagrant-root")
		ran.vm.network "public_network", ip: "fc00::1", mac: "00154d000000",bridge: "vf0_0"
		ran.vm.provider "virtualbox" do |virtualbox|
			virtualbox.memory = "512"
			virtualbox.cpus = "1"
			virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
			virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
		end
                ran.vm.provision "shell", path: "config/config_ran.sh"
	end

	# Node NFV1 configuration
	config.vm.define "nfv1" do |nfv1|
		nfv1.vm.box = "srouting/srv6-net-prog"
		nfv1.vm.box_version = "0.4.14"
                nfv1.vm.synced_folder(".", nil, :disabled => true, :id => "vagrant-root")
		nfv1.vm.network "public_network", ip: "fc00::2", mac: "00154d000001",bridge: "vf0_1"
		nfv1.vm.provider "virtualbox" do |virtualbox|
			virtualbox.memory = "512"
			virtualbox.cpus = "1"
			virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
			virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
		end
                nfv1.vm.provision "shell", path: "config/config_nfv1.sh"
	end

	# Node NFV2 configuration
	config.vm.define "nfv2" do |nfv2|
		nfv2.vm.box = "srouting/srv6-net-prog"
		nfv2.vm.box_version = "0.4.14"
                nfv2.vm.synced_folder(".", nil, :disabled => true, :id => "vagrant-root")
		nfv2.vm.network "public_network", ip: "fc00::3", mac: "00154d000002",bridge: "vf0_2"
		nfv2.vm.provider "virtualbox" do |virtualbox|
			virtualbox.memory = "512"
			virtualbox.cpus = "1"
			virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
			virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
		end
                nfv2.vm.provision "shell", path: "config/config_nfv2.sh"
	end

	# Node UPF configuration
	config.vm.define "upf" do |upf|
		upf.vm.box = "srouting/srv6-net-prog"
		upf.vm.box_version = "0.4.14"
                upf.vm.synced_folder(".", nil, :disabled => true, :id => "vagrant-root")
		upf.vm.network "public_network", ip: "fc00::4", mac: "00154d000003",bridge: "vf0_3"
		upf.vm.provider "virtualbox" do |virtualbox|
			virtualbox.memory = "512"
			virtualbox.cpus = "1"
			virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
			virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
		end
                upf.vm.provision "shell", path: "config/config_upf.sh"
	end

end