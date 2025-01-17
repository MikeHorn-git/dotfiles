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
KITTY_DIR := ./kitty
NVIM_DIR := ./nvim
SCRIPT_DIR := ./scripts
SDDM_DIR := ./sddm
THINK_DIR := ./thinkfan
TMUX_DIR := ./tmux
TOFI_DIR := ./tofi
WAYBAR_DIR := ./waybar
WLOGOUT_DIR := ./wlogout

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
	@echo "  kitty           "
	@echo "  nvim            Copy Neovim configuration files"
	@echo "  sddm            "
	@echo "  scripts         Execute scripts and log outputs"
	@echo "  thinkfan        Copy Thinkfan configuration files to /etc"
	@echo "  tmux            Copy Tmux configuration files to .config"
	@echo "  tofi            Copy Tofi configuration files to .config"
	@echo "  waybar          Copy Waybar configuration files to .config"
	@echo "  wlogout         "
	@echo "  base            Set up base configurations (Hyprland, Sddm, Tofi, Waybar, Wlogout)"
	@echo "  custom          Set up custom configurations (Assets, Dotfiles, Thinkfan)"
	@echo "  utils           Set up utility configurations (Kitty, Neovim, Tmux)"
	@echo "  all             Run all setup tasks (Base, Custom, Utils)"
	@echo "  prune           Remove all log files in the scripts directory"
	@echo "  clean           Remove all configurations and clean directories"

assets:
	$(CP) $(ASSETS_DIR) $(CONFIG_DIR)/assets

dots:
	cp .gdbinit  .gitconfig  .gtkrc-2.0 .zshrc $(HOME)
	cp xsettingsd $(CONFIG_DIR)

hyprland:
	$(CP) $(wildcard $(HYPR_DIR)/*.conf) $(CONFIG_DIR)/$(HYPR_DIR)

kitty:
	$(CP) $(wildcard $(KITTY_DIR)/*.conf) $(CONFIG_DIR)/$(KITTY_DIR)

nvim:
	$(CP) $(NVIM_DIR) $(CONFIG_DIR)/nvim

sddm:
	$SU) $(CP) $(SDDM_DIR) /etc

scripts:
	$(SH) $(SCRIPT_DIR)/thinkfan.sh | tee $(SCRIPT_DIR)/thinkfan.log
	$(SH) $(SCRIPT_DIR)/harden.sh | tee $(SCRIPT_DIR)/harden.log
	$(SH) $(SCRIPT_DIR)/utils.sh | tee $(SCRIPT_DIR)/utils.log

thinkfan:
	$(SU) $(CP) $(THINK_DIR) $(ETC_DIR)

tmux:
	$(CP) $(TMUX_DIR) $(CONFIG_DIR)/tmux

tofi:
	$(CP) $(TOFI_DIR) $(CONFIG_DIR)/tofi

waybar:
	$(CP) $(WAYBAR_DIR) $(CONFIG_DIR)/waybar

wlogout:
	$(CP) $(wildcard $(WLOGOUT_DIR)/*) $(CONFIG_DIR)/$(WLOGOUT_DIR)

base: hyprland sddm tofi waybar wlougout

custom: assets dots thinkfan

utils: kitty nvim tmux

all: base custom utils

prune:
	rm -f $(LOG_FILES)

clean:
	rm $(HOME).gdbinit $(HOME).gitconfig $(HOME).gtkrc-2.0 $(HOME).zshrc
	rm -rf $(CONFIG_DIR)/assets
	rm -rf $(CONFIG_DIR)/hypr
	rm -rf $(CONFIG_DIR)/nvim
	rm -rf $(CONFIG_DIR)/tmux
	rm -rf $(CONFIG_DIR)/tofi
	rm -rf $(CONFIG_DIR)/waybar
	rm -rf $(CONFIG_DIR)/xsettingsd
	$(SU) rm /etc/sddm.conf /etc/thinkfan.conf
	$(SU) rm -rf /etc/systemd/system/thinkfan.service.d/

.PHONY: help assets dots hyprland kitty nvim sddm scripts thinkfan tmux tofi waybar wlogout base custom utils all prune clean
