{ config, pkgs, inputs, ... }:

{
  home.username = "archlinux";
  home.homeDirectory = "/home/archlinux";

  targets.genericLinux.enable = true;

  home.stateVersion = "24.05"; # Please read the comment before changing.

  programs = {
    firefox = {
      enable = true;
    };
    
    git = {
      enable = true;
      userName = "MikeHorn-git";
      userEmail = "MikeHornProton@proton.me";
    };

    neovim =
    let
        toLua = str: "lua << EOF\n${str}\nEOF\n";
        toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
        enable = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        extraPackages = with pkgs; [
          lua-language-server
          ruff
        ];

        plugins = with pkgs.vimPlugins; [

          {
            plugin = harpoon;
            config = toLuaFile ./nvim/after/plugin/harpoon.lua;
          }

          {
            plugin = lsp-zero-nvim;
            config = toLuaFile ./nvim/after/plugin/lsp.lua;
          }

          {
            plugin = lualine-nvim;
            config = toLuaFile ./nvim/after/plugin/lualine.lua;
          }

          nvim-cmp
          nvim-lspconfig
          mason-lspconfig-nvim
          mason-nvim

          {
            plugin = telescope-nvim;
            config = toLuaFile ./nvim/after/plugin/telescope.lua;
          }

          {
            plugin = tokyonight-nvim;
            config = toLuaFile ./nvim/after/plugin/tokyonight.lua;
          }

          {
            plugin = trouble-nvim;
            config = toLuaFile ./nvim/after/plugin/trouble.lua;
          }

          undotree
          vim-be-good
          vim-fugitive

          {
            plugin = which-key-nvim;
            config = toLuaFile ./nvim/after/plugin/which-key.lua;
          }

          {
            plugin = zen-mode-nvim;
            config = toLuaFile ./nvim/after/plugin/zen.lua;
          }

          # Dependencies
          cmp-nvim-lsp
          luasnip
          nvim-web-devicons
          plenary-nvim

          {
            plugin = (nvim-treesitter.withPlugins (p: [
              p.tree-sitter-nix
              p.tree-sitter-vim
              p.tree-sitter-bash
              p.tree-sitter-lua
              p.tree-sitter-python
              p.tree-sitter-json
            ]));
            config = toLuaFile ./nvim/after/plugin/treesitter.lua;
          }
        ];
    };

    tmux = {
      enable = true;
    };

    zsh = {
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "thefuck" ];
        theme = "robbyrussell";
      };
    };
  };
 
  home.file = {
    ".tmux.conf" = {
      source = ./tmux/tmux.conf;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
