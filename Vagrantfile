
# WiFiMon dev environment
#


hosts = [
      [ "wifimon",            "10.0.0.2" ]

      # This is built last so it can provision the others
      #[ "controller",           "10.0.0.10" ]
]


private_network_name = "wifimon-"
private_network_name << ENV['USER']

etc_hosts = hosts.map { |host, ip| "#{ip} #{host}" }.join("\n")

Vagrant.configure("2") do |config|
  
  # Port forward
  config.vm.network "forwarded_port", guest: 5601, host: 5601
  config.vm.network "forwarded_port", guest: 8441, host: 8441

  # The default E1000 has a security vulerability.
  # this suppresses a Vagrant complaint
  config.vm.provider "virtualbox" do |vbox|
    vbox.default_nic_type = "82543GC"
  end

  hosts.each do |name, ip|
    config.vm.define name do |host|
      host.vm.provider "virtualbox" do |vb|
        vb.cpus = 2
        vb.memory = 5120
        # Don't need the guest extensions on this host.
        if Vagrant.has_plugin?("vagrant-vbguest")
          config.vbguest.auto_update = false
        end
      end

      host.vm.box = "ubuntu/bionic64"
      host.vm.hostname = name
      host.vm.network "private_network", ip: ip, virtualbox__intnet: private_network_name

      # Fill the hosts file

      host.vm.provision "#{name}-hosts", type: "shell", run: "always", inline: <<-SHELL

        set -e

        fgrep localhost /etc/hosts > /etc/hosts.build
        echo "#{etc_hosts}" >> /etc/hosts.build
        mv -f /etc/hosts.build /etc/hosts
	
	SHELL

      config.vm.provision "ansible" do |ansible|
	ansible.verbose = "v"
        #ansible.tags="wifimon"
	ansible.playbook = "vagrant.yml"
      end
    end  # Config
  end  # hosts.each
end
