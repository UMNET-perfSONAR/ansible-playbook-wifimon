
# perfSONAR dev environment
#


hosts = [
      [ "centos",             "10.0.0.2" ],
      [ "debian",             "10.0.0.3" ],

      # This is built last so it can provision the others
      [ "controller",           "10.0.0.10" ]
]

# make this work properly
# XXX automate UID
private_network_name = "template-UID"

etc_hosts = hosts.map { |host, ip| "#{ip} #{host}" }.join("\n")

Vagrant.configure("2") do |config|

  # The default E1000 has a security vulerability.
  # this suppresses a Vagrant complaint
  config.vm.provider "virtualbox" do |vbox|
    vbox.default_nic_type = "82543GC"
  end

  hosts.each do |name, ip|

    config.vm.define name do |host|

      host.vm.provider "virtualbox" do |vb|
        vb.cpus = 2
        vb.memory = 4096
        # Don't need the guest extensions on this host.
        if Vagrant.has_plugin?("vagrant-vbguest")
          config.vbguest.auto_update = false
        end
      end

      if name == "debian"
          host.vm.box = "debian/stretch64"
      else # if name
          host.vm.box = "centos/7"
      end # if name

      host.vm.hostname = name

      host.vm.network "private_network", ip: ip, virtualbox__intnet: private_network_name

      # Fill the hosts file

      host.vm.provision "#{name}-hosts", type: "shell", run: "always", inline: <<-SHELL

        set -e

        fgrep localhost /etc/hosts > /etc/hosts.build
        echo "#{etc_hosts}" >> /etc/hosts.build
        mv -f /etc/hosts.build /etc/hosts

      SHELL

      # Account and system setup

      host.vm.provision "#{name}-ansible-user", type: "shell", run: "always", inline: <<-SHELL

        set -e

        cd /vagrant
        ./build-ansible-account ./ssh/id_rsa.pub

      SHELL

      # Controller-only setup
      if name == "controller"
        #host.vm.synced_folder "..", "/vagrant", type: "virtualbox"
        host.vm.provision "ansible-controller", type: "shell", run: "always", inline: <<-SHELL

          set -e

          cd /vagrant
          ./provision-controller

        SHELL

      end  # If controller

    end  # Config

  end  # hosts.each

end
