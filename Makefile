CONFIG_DIR := $(HOME)/.config
ETC_DIR    := /etc

.DEFAULT_GOAL := help
.DELETE_ON_ERROR:
.ONESHELL:
.SILENT:
.SUFFIXES:

DOTFILES := assets fastfetch hypr kitty nvim tofi waybar

help:
	echo "Usage: make <target>"
	echo "Targets:"
	printf "  %-10s %s\n" "help"       "Display this help message"
	printf "  %-10s %s\n" "assets"     "Install assets"
	printf "  %-10s %s\n" "fastfetch"  "Install fastfetch config"
	printf "  %-10s %s\n" "hypr"       "Install Hyprland config"
	printf "  %-10s %s\n" "kitty"      "Install Kitty config"
	printf "  %-10s %s\n" "nvim"       "Install Neovim config"
	printf "  %-10s %s\n" "tofi"       "Install Tofi config"
	printf "  %-10s %s\n" "waybar"     "Install Waybar config"
	printf "  %-10s %s\n" "all"        "Install all dotfiles"
	printf "  %-10s %s\n" "clean"      "Remove installed dotfiles"

# Generic rule for each dotfile directory
$(DOTFILES):
	echo "[+] Installing $@"
	mkdir -p $(CONFIG_DIR)/$@
	cp -r $@/* $(CONFIG_DIR)/$@/

all: $(DOTFILES)

clean:
	echo "[-] Removing dotfiles"
	for dir in $(DOTFILES); do \
		rm -rf $(CONFIG_DIR)/$$dir; \
	done

test:
	test -d $(CONFIG_DIR)

.PHONY: help $(DOTFILES) all clean test
