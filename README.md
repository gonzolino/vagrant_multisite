# vagrant_multisite
Vagrant environment for a multi-region devstack setup.

The devstack setup simulates an openstack deployment spanning over three sites
(One BDC and two FDC sites). Each site is configured as a single region,
consisting of a control and a compute node. The BDC site is configured to hold
the 'primary' region which runs horizon and keystone for all other regions.

# Installation
1.  To start the installation, let vagrant start and provision all needed vms
    with

    ```
    vagrant up
    ```

    This will start 6 vms, clone the devstack repository onto them and
    configure the localrc file for each vm as needed with its region name, the
    services to enable, etc.

2.  The next step is to install devstack on all of the vms. For this you need
    to ssh into the vms and execute the ```stack.sh``` script.

    ```
    vagrant ssh <vm>
    ./devstack/stack.sh
    ```

    While the procedure for each vm is the same, it is important to do the
    installation in the correct order (Setup BDC before FDCs and control nodes
    before compute nodes):
    1. bdc1
    2. fdc1
    3. fdc2
    4. bdc1_com
    5. fdc1_com
    6. fdc2_com

# Run Multi-Region Heat Stacks
To create multi-region stacks for heat, you must first create a stack for a single region and then create a stack which consists of Heat::Stack resources referencing the single region stack template and the region where to create this stack. For examples take a look at the templates directory.

## Run the wordpress multi region example template
The template directory contains a wordpress_multi_region template which can be used as a showcase for how to deploy applications to a multi-region setup.
The template deploys a wordpress installation to each of the three regions defined by this environment. A wordpress installation consists of a web and a database server, both deployed to different availability zones.

The execution of this template requires the following steps:

1.  Create the needed availability zones in each region (The three control
    nodes are bdc1, fdc1 and fdc2)

    ```
    vagrant ssh <control-node>
    source devstack/openrc admin
    nova aggregate-create dmz dmz
    nova aggregate-create mz mz
    ```

2.  Create a keypair on bdc1 and distribute it to all regions using the
    provided keypairs template

    ```
    vagrant ssh bdc1
    source devstack/openrc
    ssh-keygen
    heat stack-create -f /vagrant/templates/keypairs.yaml -P key_name=heat_key keypairs
    ```

    Ensure that you name the key created by `ssh-keygen` id_rsa
3.  Download the image needed by the wordpress servers

    ```
    wget http://cloud.fedoraproject.org/fedora-20.x86_64.qcow2
    vagrant ssh <control-node>
    source devstack/openrc
    openstack image create --file /vagrant/fedora-20.x86_64.qcow2 fedora-20.x86_64
    ```

    > TODO: Create a heat template for this

4.  Create the wordpress multi region template

    ```
    vagrant ssh bdc1
    source devstack/openrc
    heat stack-create --file /vagrant/templates/wordpress_multi_region.yaml -P key_name=heat_key -P db_availability_zone=mz -P web_availability_zone=dmz -P db_name=wordpress -P db_username=wordpress -P db_password=secrete -P db_root_password=secrete wordpress
    ```