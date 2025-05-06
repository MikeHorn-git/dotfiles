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
	@echo "  dots            Copy dotfiles to home directory"
	@echo "  fastfetch       Copy Fastfetch configuration file"
	@echo "  kitty           Copy Kitty configuration files"
	@echo "  nix             Copy nix configuration file"
	@echo "  nvim            Copy Neovim configuration files"
	@echo "  scripts         Execute scripts"
	@echo "  sddm            Copy sddm configuration files"
	@echo "  thinkfan        Copy Thinkfan configuration files to /etc"
	@echo "  tmux            Copy Tmux configuration file"
	@echo "  clean           Remove all configurations and clean directories"

dots:
	cp .gdbinit  .gitconfig  .zshrc $(HOME)

fastfetch:
	$(CP) fastfetch $(CONFIG_DIR)/fastfetch

kitty:
	$(CP) $(wildcard kitty/*.conf) $(CONFIG_DIR)/kitty

nix:
	$(CP) nix $(CONFIG_DIR)/nix

nvim:
	$(CP) nvim $(CONFIG_DIR)/nvim

scripts:
	for script in scripts/*.sh; do \
		$(SH) $$script; \
	done

sddm:
	$(SU) $(CP) sddm/sddm.conf /etc
	$(SU) mkdir -p /etc/sddm.conf.d
	$(SU) $(CP) sddm/virtualkbd.conf /etc/sddm.conf.d

thinkfan:
	$(SU) $(CP) thinkfan/thinkfan.conf /etc

tmux:
	$(CP) tmux $(CONFIG_DIR)/tmux

clean:
	rm $(HOME).gdbinit $(HOME).gitconfig $(HOME).gtkrc-2.0 $(HOME).zshrc
	rm -rf $(CONFIG_DIR)/nvim
	rm -rf $(CONFIG_DIR)/tmux
	$(SU) rm /etc/sddm.conf /etc/thinkfan.conf
	$(SU) rm -rf /etc/systemd/system/thinkfan.service.d/

.PHONY: help dots fastfetch kitty nix nvim sddm scripts thinkfan tmux clean
