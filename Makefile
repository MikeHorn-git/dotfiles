# Binaries
CP = cp -r
SH := bash
SU := sudo

# Destination Directories
CONFIG_DIR := $(HOME)/.config
ETC_DIR := /etc

# Source Directories
ASSETS_DIR := ./assets
HYPR_DIR := ./hypr
NVIM_DIR := ./nvim
SCRIPT_DIR := ./scripts
SDDM_DIR := ./sddm
THINK_DIR := ./thinkfan
TMUX_DIR := ./tmux
TOFI_DIR := ./tofi
WAYBAR_DIR := ./waybar

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
	@echo "  dots            Copy dotfiles to home directory"
	@echo "  hyprland        Copy Hyprland configuration files"
	@echo "  nvim            Copy Neovim configuration files"
	@echo "  scripts         Execute scripts and log outputs"
	@echo "  thinkfan        Copy Thinkfan configuration files to /etc"
	@echo "  tmux            Copy Tmux configuration files to .config"
	@echo "  tofi            Copy Tofi configuration files to .config"
	@echo "  waybar          Copy Waybar configuration files to .config"
	@echo "  base            Set up base configurations (Hyprland, Tofi, Waybar)"
	@echo "  custom          Set up custom configurations (Assets, Dotfiles, Thinkfan)"
	@echo "  utils           Set up utility configurations (Neovim, Tmux)"
	@echo "  all             Run all setup tasks (Base, Utils)"
	@echo "  prune           Remove all log files in the scripts directory"
	@echo "  clean           Remove all configurations and clean directories"

assets:
	$(CP) $(ASSETS_DIR) $(CONFIG_DIR)/assets

dots:
	cp .gdbinit  .gitconfig  .gtkrc-2.0 $(HOME)

hyprland:
	$(CP) $(wildcard $(HYPR_DIR)/*.conf) $(CONFIG_DIR)/$(HYPR_DIR)

nvim:
	$(CP) $(NVIM_DIR) $(CONFIG_DIR)/nvim

scripts:
	$(SH) $(SCRIPT_DIR)/thinkfan.sh | tee $(SCRIPT_DIR)/thinkfan.log
	$(SH) $(SCRIPT_DIR)/harden.sh | tee $(SCRIPT_DIR)/harden.log
	$(SH) $(SCRIPT_DIR)/utils.sh | tee $(SCRIPT_DIR)/utils.log

thinkfan:
	$(CP) $(THINK_DIR) $(ETC_DIR)

tmux:
	$(CP) $(TMUX_DIR) $(CONFIG_DIR)/tmux

tofi:
	$(CP) $(TOFI_DIR) $(CONFIG_DIR)/tofi

waybar:
	$(CP) $(WAYBAR_DIR) $(CONFIG_DIR)/waybar

base: hyprland tofi waybar

custom: assets dots thinkfan

utils: nvim tmux

all: base utils

prune:
	rm -f $(LOG_FILES)

clean:
	rm $(HOME).gdbinit $(HOME).gitconfig $(HOME).gtkrc-2.0
	rm -rf $(CONFIG_DIR)/assets
	rm -rf $(CONFIG_DIR)/hypr
	rm -rf $(CONFIG_DIR)/nvim
	rm -rf $(CONFIG_DIR)/tmux
	rm -rf $(CONFIG_DIR)/tofi
	rm -rf $(CONFIG_DIR)/waybar
	$(SU) rm /etc/sddm.conf /etc/thinkfan.conf
	$(SU) rm -rf /etc/systemd/system/thinkfan.service.d/

.PHONY: help assets dots hyprland nvim scripts thinkfan tmux tofi waybar base custom utils all prune clean
