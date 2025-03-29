.PHONY: help bootstrap up destroy clean test provision provision-host test-host

# Default target when just running 'make'
.DEFAULT_GOAL := help

# Help
help:
	@echo "Available targets:"
	@echo "  bootstrap     - Create Python venv and install requirements"
	@echo "  up           - Create and provision VMs (runs bootstrap first)"
	@echo "  destroy      - Destroy all VMs"
	@echo "  clean        - Full cleanup: destroy VMs, remove .vagrant and venv"
	@echo "  provision    - Run Ansible bootstrap playbook via Vagrant"
	@echo "  provision-host - Run Ansible bootstrap playbook directly from host"
	@echo "  test         - Full test cycle: clean -> up -> provision -> final cleanup"
	@echo "  test-host    - Full test cycle using host-based provisioning"
	@echo ""
	@echo "Example: make up    # Create and provision VMs"

# Create Python venv and install requirements
bootstrap:
	python3 -m venv venv
	. venv/bin/activate && pip install -r requirements.txt

# Start VMs (creates venv if needed)
up:
	test -f venv/bin/activate || $(MAKE) bootstrap
	. venv/bin/activate && vagrant up

# Run Ansible bootstrap playbook via Vagrant
provision:
	test -f venv/bin/activate || $(MAKE) bootstrap
	. venv/bin/activate && vagrant provision

# Run Ansible bootstrap playbook directly from host
provision-host:
	test -f venv/bin/activate || $(MAKE) bootstrap
	. venv/bin/activate && ansible-playbook ansible/bootstrap.yml

# Destroy VMs
destroy:
	vagrant destroy -f

# Clean everything (VMs, .vagrant, venv)
clean: destroy
	rm -rf .vagrant venv

# Full test cycle: clean -> up -> provision -> final cleanup
test: clean up provision
	$(MAKE) clean

# Full test cycle with host-based provisioning: clean -> up -> provision-host -> destroy VMs only
test-host: clean up provision-host
	$(MAKE) destroy 