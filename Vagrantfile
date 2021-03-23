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
			virtualbox.memory = "2048"
			virtualbox.cpus = "4"
			virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
			virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
		end
                ran.vm.provision "shell", path: "config/config_ran.sh"
				ran.vm.provision "file", source: "files/gpt2.py", destination: "gpt2.py"
				ran.vm.provision "file", source: "files/send_gtp.py", destination: "send_gtp.py"
				ran.vm.provision "file", source: "files/send_gtp2.py", destination: "send_gtp2.py"
				ran.vm.provision "file", source: "files/send_pkt.py", destination: "send_pkt.py"
				ran.vm.provision "file", source: "files/receive.py", destination: "receive.py"
				ran.vm.provision "file", source: "files/receive2.py", destination: "receive2.py"
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
				nfv1.vm.provision "file", source: "files/gpt2.py", destination: "gpt2.py"
				nfv1.vm.provision "file", source: "files/send_gtp.py", destination: "send_gtp.py"
				nfv1.vm.provision "file", source: "files/send_gtp2.py", destination: "send_gtp2.py"
				nfv1.vm.provision "file", source: "files/send_pkt.py", destination: "send_pkt.py"
				nfv1.vm.provision "file", source: "files/receive.py", destination: "receive.py"
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
				nfv2.vm.provision "file", source: "files/gpt2.py", destination: "gpt2.py"
				nfv2.vm.provision "file", source: "files/send_gtp.py", destination: "send_gtp.py"
				nfv2.vm.provision "file", source: "files/send_gtp2.py", destination: "send_gtp2.py"
				nfv2.vm.provision "file", source: "files/send_pkt.py", destination: "send_pkt.py"
				nfv2.vm.provision "file", source: "files/receive.py", destination: "receive.py"				
	end

	# Node UPF configuration
	config.vm.define "upf" do |upf|
		upf.vm.box = "srouting/srv6-net-prog"
		upf.vm.box_version = "0.4.14"
                upf.vm.synced_folder(".", nil, :disabled => true, :id => "vagrant-root")
		upf.vm.network "public_network", ip: "fc00::4", mac: "00154d000003",bridge: "vf0_3"
		upf.vm.provider "virtualbox" do |virtualbox|
			virtualbox.memory = "2048"
			virtualbox.cpus = "4"
			virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
			virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
		end
                upf.vm.provision "shell", path: "config/config_upf.sh"
				upf.vm.provision "file", source: "files/gpt2.py", destination: "gpt2.py"
				upf.vm.provision "file", source: "files/send_gtp.py", destination: "send_gtp.py"
				upf.vm.provision "file", source: "files/send_gtp2.py", destination: "send_gtp2.py"
				upf.vm.provision "file", source: "files/send_pkt.py", destination: "send_pkt.py"
				upf.vm.provision "file", source: "files/receive.py", destination: "receive.py"				
	end

	# Node DASH SERVER configuration
	config.vm.define "dashServer" do |ds|
		ds.vm.box = "srouting/srv6-net-prog"
		ds.vm.box_version = "0.4.14"
		#ds.vm.hostname = "ds"
		ds.vm.network "public_network", ip: "fc00::8",mac: "00154d000004", bridge: "vf0_4"
		ds.vm.provider "virtualbox" do |virtualbox|
			virtualbox.memory = 2048
			virtualbox.cpus = 2
			virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
			virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
		end
				ds.vm.provision "shell", path: "config/dashServer/config_dashServer.sh"
			ds.vm.provision "ansible" do |ansible| 
				ansible.playbook = "config/dashServer/dashServer-playbook.yml"
			end
	end

	config.vm.define "clientVlc" do |vlc|
		# Node DASH SERVER configuration
		vlc.vm.box = "leandrocdealmeida/ubuntu-vlc"
		#vlc.vm.hostname = "vlc"
		vlc.vm.network "public_network",mac: "00154d000005", bridge: "vf0_5"
		vlc.vm.provider "virtualbox" do |virtualbox|
			virtualbox.memory = 2048
			virtualbox.cpus = 2
			virtualbox.customize ["modifyvm", :id, "--vrde", "on"]
			virtualbox.customize ["modifyvm", :id, "--vrdeport", "19101"]
			virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
			virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
		end
				vlc.vm.provision "shell", path: "config/clientVlc/config_clientVlc.sh"
	end

end