# Multi-VM Ansible Example

A Vagrant environment demonstrating multi-VM setup with Ansible provisioning.

## Prerequisites

- Python 3
- Vagrant
- One of the following hypervisors and its Vagrant provider:
  - VMware Fusion/Workstation with vagrant-vmware-desktop plugin
  - Parallels Desktop Pro with vagrant-parallels plugin

## Development Environment

This example was developed and tested on:
- macOS running on Apple Silicon (M1/M2)
- VMware Fusion and Parallels Desktop Pro
- Debian 12 ARM64 boxes

## Quick Start

```bash
# Install required Vagrant plugin (choose one)
vagrant plugin install vagrant-vmware-desktop  # For VMware
vagrant plugin install vagrant-parallels      # For Parallels

# Create and provision VMs
make up

# Run Ansible playbook directly on hosts
make provision-host

# Full test cycle (clean -> up -> provision -> clean)
make test
```

## Available Make Targets

```bash
make help          # Show all available targets
make up           # Create and provision VMs
make provision    # Run Ansible playbook via Vagrant
make destroy      # Destroy VMs
make clean        # Full cleanup (VMs, .vagrant, venv)
```

## Environment

- 2 Debian 12 VMs (pgn11, pgn12)
- Python virtual environment for dependencies
- Ansible for configuration management
- Works with both VMware and Parallels providers
- Native performance on Apple Silicon through ARM64 boxes

## Structure

```
.
├── Makefile              # Build automation
├── Vagrantfile          # VM definitions
├── ansible.cfg          # Ansible configuration
├── ansible/            
│   ├── bootstrap.yml    # Main playbook
│   ├── group_vars/      # Group variables
│   └── host_vars/       # Host-specific variables
└── requirements.txt     # Python dependencies
``` 