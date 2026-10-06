# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/bionic64"
  config.vm.network "public_network"
  config.vm.boot_timeout = 600


  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
  
     # Customize the amount of memory on the VM:
    vb.memory = "4086"
    vb.cpus = 4
  end
  
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    curl -fsSL https://tailscale.com/install.sh | sh

    echo 'net.ipv4.ip_forward = 1' | tee -a /etc/sysctl.d/99-tailscale.conf
    echo 'net.ipv6.conf.all.forwarding = 1' | tee -a /etc/sysctl.d/99-tailscale.conf
    sysctl -p /etc/sysctl.d/99-tailscale.conf

    tailscale up

    tailscale set --advertise-exit-node
    tailscale set --advertise-routes=#{ENV["TAILSCALE_ROUTES"]}
    tailscale up


  SHELL
end
