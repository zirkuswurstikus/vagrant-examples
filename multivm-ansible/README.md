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

# Show available commands
make help

# Example: Create and provision VMs
make up
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