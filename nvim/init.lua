-- Set leader
vim.g.mapleader = " "

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Lazy.nvim setup
require("lazy").setup {
  {
    "MikeHorn-git/LowVim",
    lazy = false,
    import = "lowvim.plugins",
  },
}

-- Load core modules
require "lowvim.options"
require "lowvim.autocmds"
require "lowvim.keymaps"
require "lowvim.diagnostics"
require "lowvim.lsp"
