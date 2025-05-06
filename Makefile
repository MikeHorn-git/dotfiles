# Binaries
CP = cp -r
SH := bash
SU := sudo

# Destination Directories
CONFIG_DIR := $(HOME)/.config

.DEFAULT_GOAL := help

help:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  help            Show this help message"
	@echo "  assets          Copy assets directory"
	@echo "  sway            Copy Sway configuration file"
	@echo "  clean           Remove all configurations and clean directories"

assets:
	$(CP) assets $(CONFIG_DIR)/assets

tofi:
	$(CP) sway $(CONFIG_DIR)/sway

clean:
	rm -rf $(CONFIG_DIR)/assets
	rm -rf $(CONFIG_DIR)/sway

.PHONY: help assets sway clean
