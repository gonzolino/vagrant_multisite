# -*- mode: ruby -*-
# vi: set ft=ruby :

hosts = {
  :bdc1 => {
    :ip => '192.168.33.10',
    :hostname => 'bdc1',
    :provision_script => 'install_bdc.sh',
    :provision_args => '192.168.33.10 rg_bdc1'
  },
  :fdc1 => {
    :ip => '192.168.33.11',
    :hostname => 'fdc1',
    :provision_script => 'install_fdc.sh',
    :provision_args => '192.168.33.11 192.168.33.10 rg_fdc1'
  },
  :fdc2 => {
    :ip => '192.168.33.12',
    :hostname => 'fdc2',
    :provision_script => 'install_fdc.sh',
    :provision_args => '192.168.33.12 192.168.33.10 rg_fdc2'
  }
}

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 6144
    vb.cpus = 4
  end

  if Vagrant.has_plugin?("vagrant-proxyconf")
    if ENV["http_proxy"]
      config.proxy.http = ENV["http_proxy"]
    end
    if ENV["https_proxy"]
      config.proxy.https = ENV["https_proxy"]
    end
    config.proxy.no_proxy = "localhost,127.0.0.1"
  end

  config.vm.provision :shell do |shell|
    shell.path = "install_base.sh"
  end

  hosts.each do |name, cfg|
   config.vm.define name do |server|
     server.vm.hostname = cfg[:hostname]
     server.vm.network "private_network", ip: cfg[:ip]
  
     server.vm.provision :shell do |shell|
       shell.path = cfg[:provision_script]
       shell.args = cfg[:provision_args]
     end

     config.proxy.no_proxy << "," << cfg[:ip]
   end
  end
end
