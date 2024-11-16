# Binaries
CP = cp -r
SH := bash
SU := sudo

# Directories
ASSETS_DIR := ./assets
CONFIG_DIR := $(HOME)/.config
ETC_DIR := ./etc
HYPR_DIR := ./hypr
NVIM_DIR := ./nvim
SCRIPT_DIR := ./scripts
TMUX_DIR := ./tmux

# Nix
NIX_TARGET := .#archlinux

# Wildcard for log files in the scripts directory
LOG_FILES := $(wildcard $(SCRIPT_DIR)/*.log)
# Wildcard for config files in the etc directory
ETC_CONF_FILES := $(wildcard $(ETC_DIR)/*.conf)

.DEFAULT_GOAL := help

help:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  help            Show this help message"
	@echo "  assets          Copy assets directory to .config"
	@echo "  dots            Copy dotfiles and etc config files"
	@echo "  hyprland        Copy Hyprland configuration files"
	@echo "  nix             Switch Nix home-manager configuration"
	@echo "  nvim            Copy Neovim configuration files"
	@echo "  scripts         Run custom scripts and log the output"
	@echo "  tmux            Copy Tmux configuration files"
	@echo "  all             Run all setup tasks (assets, dots, hyprland, nvim, scripts)"
	@echo "  base            Runbase setup tasks (assets, hyprland, nvim)"
	@echo "  prune           Remove all log files in the scripts directory"
	@echo "  clean           Clean everything"

assets:
	$(CP) $(ASSETS_DIR) $(CONFIG_DIR)/assets

dots:
	cp .gdbinit  .gitconfig  .gtkrc-2.0 $(HOME)
	$(SU) cp $(ETC_CONF_FILES) /etc/
	$(SU) cp $(ETC_DIR)/systemd/system/thinkfan.service.d/override.conf /etc/systemd/system/thinkfan.service.d/override.conf

hyprland:
	$(CP) $(wildcard $(HYPR_DIR)/*.conf) $(CONFIG_DIR)/$(HYPR_DIR)

nix:
	home-manager switch --flake $(NIX_TARGET)

nvim:
	$(CP) $(NVIM_DIR) $(CONFIG_DIR)/nvim

scripts:
	$(SH) $(SCRIPT_DIR)/thinkfan.sh | tee $(SCRIPT_DIR)/thinkfan.log
	$(SH) $(SCRIPT_DIR)/harden.sh | tee $(SCRIPT_DIR)/harden.log
	$(SH) $(SCRIPT_DIR)/utils.sh | tee $(SCRIPT_DIR)/utils.log

tmux:
	$(CP) $(TMUX_DIR) $(CONFIG_DIR)/tmux

all: assets dots hyprland nvim scripts

base: assets hyprland nvim

prune:
	rm -f $(LOG_FILES)

clean:
	rm $(HOME).gdbinit $(HOME).gitconfig $(HOME).gtkrc-2.0
	rm -rf $(CONFIG_DIR)/assets
	rm -rf $(CONFIG_DIR)/hypr
	rm -rf $(CONFIG_DIR)/nvim
	rm -rf $(CONFIG_DIR)/tmux
	$(SU) rm /etc/sddm.conf /etc/thinkfan.conf
	$(SU) rm -rf /etc/systemd/system/thinkfan.service.d/

.PHONY: help assets dots hyprland nix nvim scripts tmux all base prune clean
