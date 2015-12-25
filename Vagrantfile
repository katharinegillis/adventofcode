Vagrant.configure(2) do |config|
  # Set up the box.
  config.vm.box = "box-cutter/centos67"

  # Turn off the vbguest auto-update.
  config.vbguest.auto_update = false

  # Set up the networking.
  config.vm.network "private_network", ip: "192.168.33.20"
  config.vm.hostname = "localdev.adventofcode.tichi.org"

  # Set up salt.
  config.vm.synced_folder "salt/", "/srv/salt"

  # Do the provisioning.
  config.vm.provision :salt do |salt|
    salt.minion_config = "salt/minion"
    salt.run_highstate = true
    salt.bootstrap_options = "-F -c /tmp"
  end
end
