# -*- mode: ruby -*-
# vim: set ft=ruby :

# Base settings for VM numbering
NODE_PREFIX = "pgn"  # Postgres Node prefix
CLUSTER_PREFIX = "pgc"  # Postgres Cluster prefix
START_NUMBER = 10  # Starting number (first VM will be START_NUMBER + 1)
NUM_INSTANCES = 2

PG_CLUSTER_NAME = "#{CLUSTER_PREFIX}#{START_NUMBER}"  # Cluster group name
# Resource allocation settings
VM_MEMORY = 4096  # Memory in MB
VM_CPUS = 4      # Number of CPUs

Vagrant.configure("2") do |config|
  # Disable shared folder mounting
  config.vm.synced_folder '.', '/vagrant', disabled: true

  # Common configuration for all VMs
  config.vm.box = "bento/debian-12"
  config.vm.provider "parallels" do |prl|
    prl.update_guest_tools = true
  end
  
  config.vm.provider "vmware_desktop" do |vmware|
    vmware.gui = false
    vmware.vmx["memsize"] = VM_MEMORY
    vmware.vmx["numvcpus"] = VM_CPUS
  end

  # Create VMs dynamically
  (1..NUM_INSTANCES).each do |i|
    vm_number = START_NUMBER + i  # Adding i instead of (i-1) to start from START_NUMBER + 1
    vm_name = "#{NODE_PREFIX}#{vm_number}"

    config.vm.define vm_name do |node|
      node.vm.hostname = vm_name
      node.vm.network "private_network", ip: "192.168.56.#{vm_number}"
      
      node.vm.provider "parallels" do |prl|
        prl.memory = VM_MEMORY
        prl.cpus = VM_CPUS
      end
      
      node.vm.provider "vmware_desktop" do |vmware|
        vmware.vmx["memsize"] = VM_MEMORY
        vmware.vmx["numvcpus"] = VM_CPUS
      end

      # Only configure Ansible but don't run it automatically
      if i == NUM_INSTANCES
        node.vm.provision "ansible", run: "never" do |ansible|
          ansible.playbook = "ansible/bootstrap.yml"
          ansible.limit = "all"
          ansible.groups = {
            "pg_nodes" => (1..NUM_INSTANCES).map { |j| "#{NODE_PREFIX}#{START_NUMBER + j}" },
            PG_CLUSTER_NAME => (1..NUM_INSTANCES).map { |j| "#{NODE_PREFIX}#{START_NUMBER + j}" },
            "all:children" => ["pg_nodes", PG_CLUSTER_NAME]
          }
          ansible.extra_vars = {
            cluster_name: PG_CLUSTER_NAME,
            start_number: START_NUMBER,
            node_prefix: NODE_PREFIX,
            cluster_prefix: CLUSTER_PREFIX,
            num_instances: NUM_INSTANCES,
            vm_memory: VM_MEMORY,
            vm_cpus: VM_CPUS
          }
        end
      end
    end
  end
end 