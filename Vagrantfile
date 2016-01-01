Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  # Set up the networking.
    config.vm.network "private_network", ip: "192.168.33.25"
    config.vm.hostname = "localdev.adventofcode.tichi.org"

    # Set up the shared web folder.
    config.vm.synced_folder "webapp/", "/home/vagrant/webapp", create: true

    # Set up salt.
    config.vm.synced_folder "salt/", "/srv/salt"

    # Do the provisioning.
    config.vm.provision :salt do |salt|
      salt.minion_config = "salt/minion"
      salt.run_highstate = true
      salt.bootstrap_options = "-F -c /tmp"
    end
end
