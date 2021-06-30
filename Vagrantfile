# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

	# Node NFV1 configuration
	config.vm.define "nfv1" do |nfv1|
		nfv1.vm.box = "srouting/srv6-net-prog"
		nfv1.vm.box_version = "0.4.14"
                nfv1.vm.synced_folder(".", nil, :disabled => true, :id => "vagrant-root")
		nfv1.vm.hostname = "NFV1"
		nfv1.vm.network "public_network", ip: "fc00::2", mac: "00154d000001",bridge: "vf0_1"
		nfv1.vm.provider "virtualbox" do |virtualbox|
			virtualbox.memory = "4096"
			virtualbox.cpus = "4"
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
		nfv2.vm.hostname = "NFV2"
		nfv2.vm.network "public_network", ip: "fc00::3", mac: "00154d000002",bridge: "vf0_2"
		nfv2.vm.provider "virtualbox" do |virtualbox|
			virtualbox.memory = "4096"
			virtualbox.cpus = "4"
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

	# Node NFV3 configuration
	config.vm.define "nfv3" do |nfv3|
		nfv3.vm.box = "srouting/srv6-net-prog"
		nfv3.vm.box_version = "0.4.14"
                nfv3.vm.synced_folder(".", nil, :disabled => true, :id => "vagrant-root")
		nfv3.vm.hostname = "NFV3"
		nfv3.vm.network "public_network", ip: "fc00::4", mac: "00154d000003",bridge: "vf0_3"
		nfv3.vm.provider "virtualbox" do |virtualbox|
			virtualbox.memory = "4096"
			virtualbox.cpus = "4"
			virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
			virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
		end
            	nfv3.vm.provision "shell", path: "config/config_nfv3.sh"
				nfv3.vm.provision "file", source: "files/gpt2.py", destination: "gpt2.py"
				nfv3.vm.provision "file", source: "files/send_gtp.py", destination: "send_gtp.py"
				nfv3.vm.provision "file", source: "files/send_gtp2.py", destination: "send_gtp2.py"
				nfv3.vm.provision "file", source: "files/send_pkt.py", destination: "send_pkt.py"
				nfv3.vm.provision "file", source: "files/receive.py", destination: "receive.py"				
	end	

	# Node DASH SERVER configuration
	config.vm.define "dashServer" do |ds|
		ds.vm.box = "ubuntu/xenial64"
		#ds.vm.box_version = "0.4.14"
		ds.vm.hostname = "ds"
		ds.vm.network "public_network", ip: "fc00::8",mac: "00154d000005", bridge: "vf0_5"
		ds.vm.network "private_network", ip: "fc20::2", mac: "080027dddddd",name: "vboxnet1"
		ds.vm.provider "virtualbox" do |virtualbox|
			virtualbox.memory = 4096
			virtualbox.cpus = 12
			virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
			virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
		end
				ds.vm.provision "shell", path: "config/dashServer/config_dashServer.sh"
				ds.vm.provision "file", source: "files/gpt2.py", destination: "gpt2.py"
				ds.vm.provision "file", source: "files/send_gtp.py", destination: "send_gtp.py"
				ds.vm.provision "file", source: "files/send_gtp2.py", destination: "send_gtp2.py"
				ds.vm.provision "file", source: "files/send_pkt.py", destination: "send_pkt.py"
				ds.vm.provision "file", source: "files/receive.py", destination: "receive.py"
			ds.vm.provision "ansible" do |ansible| 
				ansible.playbook = "config/dashServer/dashServer-playbook.yml"
			end
	end

	config.vm.define "clientVlc" do |vlc|
		vlc.vm.box = "leandrocdealmeida/ubuntu-vlc"
		vlc.vm.box_version = "01"
		vlc.vm.hostname = "vlc"
		vlc.vm.network "public_network", ip: "fc00::9",mac: "00154d000006", bridge: "vf0_6"
		vlc.vm.network "private_network", ip: "fc10::2", mac: "080027aaaaaa",name: "vboxnet0"
		vlc.vm.provider "virtualbox" do |virtualbox|
			virtualbox.memory = 8192
			virtualbox.cpus = 12
			virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
			virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
			virtualbox.customize ['modifyvm', :id, '--cableconnected3', 'on']
			virtualbox.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
			virtualbox.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
			virtualbox.customize ["modifyvm", :id, "--vrde", "on"]
			virtualbox.customize ["modifyvm", :id, "--vrdeport", "19101"]
		end
				vlc.vm.provision "shell", path: "config/clientVlc/config_clientVlc.sh"
				vlc.vm.provision "file", source: "files/gpt2.py", destination: "gpt2.py"
				vlc.vm.provision "file", source: "files/send_gtp.py", destination: "send_gtp.py"
				vlc.vm.provision "file", source: "files/send_gtp2.py", destination: "send_gtp2.py"
				vlc.vm.provision "file", source: "files/send_pkt.py", destination: "send_pkt.py"
				vlc.vm.provision "file", source: "files/receive.py", destination: "receive.py"
	end

	config.vm.define "clientNmap" do |nmap|
		nmap.vm.box = "srouting/srv6-net-prog"
		nmap.vm.box_version = "0.4.14"
		nmap.vm.hostname = "NMAP"
				nmap.vm.synced_folder(".", nil, :disabled => true, :id => "vagrant-root")
				nmap.vm.network "private_network", ip: "fc10::3", mac: "080027aaaaab",name: "vboxnet0"
		nmap.vm.provider "virtualbox" do |virtualbox|
			virtualbox.memory = "1024"
			virtualbox.cpus = "1"
			virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
		end
				nmap.vm.provision "shell", path: "config/config_clientNmap.sh"
				nmap.vm.provision "file", source: "files/gpt2.py", destination: "gpt2.py"
				nmap.vm.provision "file", source: "files/send_gtp.py", destination: "send_gtp.py"
				nmap.vm.provision "file", source: "files/send_gtp2.py", destination: "send_gtp2.py"
				nmap.vm.provision "file", source: "files/send_pkt.py", destination: "send_pkt.py"
				nmap.vm.provision "file", source: "files/receive.py", destination: "receive.py"				
	end	

end