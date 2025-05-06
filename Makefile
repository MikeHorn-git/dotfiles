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
	@echo "  hyprland        Copy Hyprland configuration files"
	@echo "  tofi            Copy Tofi configuration file"
	@echo "  waybar          Copy Waybar configuration files"
	@echo "  wlogout         Copy wlogout configuration files"
	@echo "  clean           Remove all configurations and clean directories"

assets:
	$(CP) assets $(CONFIG_DIR)/assets

hyprland:
	$(CP) $(wildcard hypr/*.conf) $(CONFIG_DIR)/hypr

tofi:
	$(CP) tofi $(CONFIG_DIR)/tofi

waybar:
	$(CP) waybar $(CONFIG_DIR)/waybar

wlogout:
	$(CP) $(wildcard wlogout/*) $(CONFIG_DIR)/wlogout

clean:
	rm -rf $(CONFIG_DIR)/assets
	rm -rf $(CONFIG_DIR)/hypr
	rm -rf $(CONFIG_DIR)/tofi
	rm -rf $(CONFIG_DIR)/waybar

.PHONY: help assets hyprland tofi waybar wlogout clean
