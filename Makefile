# Dir
CONFIG_DIR := $(HOME)/.config

.DEFAULT_GOAL := help

help:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  help            Show this help message"
	@echo "  assets          Copy Assets directory"
	@echo "  dots            Copy Dotfiles to home directory"
	@echo "  fastfetch       Copy Fastfetch configuration file"
	@echo "  hypr            Copy Hyprland configuration files"
	@echo "  kitty           Copy Kitty configuration files"
	@echo "  nix             Copy Nix configuration file"
	@echo "  nvim            Copy Neovim configuration files"
	@echo "  scripts         Execute scripts"
	@echo "  sddm            Copy Sddm configuration files"
	@echo "  sway            Copy Sway configuration file"
	@echo "  thinkfan        Copy Thinkfan configuration files to /etc"
	@echo "  tmux            Copy Tmux configuration file"
	@echo "  tofi            Copy Tofi configuration file"
	@echo "  waybar          Copy Waybar configuration files"
	@echo "  wlogout         Copy Wlogout configuration files"
	@echo "  all             Complete Hyprland setup"
	@echo "  clean           Remove all configurations and clean directories"

assets:
	cp -r assets $(CONFIG_DIR)/assets

dots:
	cp .gdbinit  .gitconfig  .zshrc $(HOME)

fastfetch:
	cp -r fastfetch $(CONFIG_DIR)/fastfetch

hypr:
	cp -r hypr $(CONFIG_DIR)/hypr

kitty:
	cp -r kitty $(CONFIG_DIR)/kitty

nix:
	cp -r nix $(CONFIG_DIR)/nix
	cp -r nixpkgs $(CONFIG_DIR)/nixpkgs

nvim:
	cp -r nvim $(CONFIG_DIR)/nvim

scripts:
	for script in scripts/*.sh; do \
		$(SH) $$script; \
	done

sddm:
	sudo cp sddm/sddm.conf /etc
	sudo mkdir -p /etc/sddm.conf.d
	sudo cp sddm/virtualkbd.conf /etc/sddm.conf.d

sway:
	cp -r sway $(CONFIG_DIR)/sway

thinkfan:
	sudo cp thinkfan/thinkfan.conf /etc

tmux:
	cp -r tmux/ $(CONFIG_DIR)/tmux

tofi:
	cp -r tofi/ $(CONFIG_DIR)/tofi

waybar:
	cp -r waybar $(CONFIG_DIR)/waybar

wlogout:
	cp -r wlogout $(CONFIG_DIR)/wlogout

all: hypr tofi waybar wlogout

clean:
	rm $(HOME).gdbinit $(HOME).gitconfig $(HOME).gtkrc-2.0 $(HOME).zshrc
	rm -rf $(CONFIG_DIR)/fastfetch
	rm -rf $(CONFIG_DIR)/kitty
	rm -rf $(CONFIG_DIR)/nix
	rm -rf $(CONFIG_DIR)/nixpkgs
	rm -rf $(CONFIG_DIR)/nvim
	rm -rf $(CONFIG_DIR)/tmux
	rm -rf $(CONFIG_DIR)/tofi
	rm -rf $(CONFIG_DIR)/waybar
	rm -rf $(CONFIG_DIR)/wlogout
	sudo rm /etc/sddm.conf /etc/thinkfan.conf
	sudo rm -rf /etc/systemd/system/thinkfan.service.d/

.PHONY: help assets dots fastfetch hypr kitty nix nvim sddm scripts thinkfan tmux tofi waybar wlogout clean all test
