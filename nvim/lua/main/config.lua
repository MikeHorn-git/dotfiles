vim.cmd("set number") -- Show line number at startup
vim.cmd("set relativenumber") -- Show relative line number, execpt for the current line

vim.o.tabstop = 4 -- Set tab value of 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.api.nvim_set_option("clipboard", "unnamed") -- Allow copy text in nvim to the OS buffer
