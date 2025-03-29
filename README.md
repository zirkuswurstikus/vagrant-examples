# Vagrant PostgreSQL Test Environment

A Vagrant environment for testing PostgreSQL clusters using VMware Fusion/Workstation.

## Prerequisites

- Python 3
- Vagrant
- VMware Fusion/Workstation with Vagrant VMware provider

## Quick Start

```bash
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