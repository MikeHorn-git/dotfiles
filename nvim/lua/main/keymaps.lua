vim.g.mapleader = " " -- Set <Space> as the leader key

-- Commands
vim.keymap.set("n", "<leader>ctws", vim.cmd.Ctws) -- Ctws [Clean Trailing WhiteSpace]
vim.keymap.set("n", "<leader>g", vim.cmd.Git) -- Fugitive [Git]
vim.keymap.set("n", "<leader>l", vim.cmd.Lazy) -- Lazy [PackageManager Plugins]
vim.keymap.set("n", "<leader>m", vim.cmd.Mason) -- Mason [PackageManager LSP]
vim.keymap.set("n", "<leader>p", vim.cmd.VimBeGood) -- VimBeGood [Training]
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle) -- Undotree [History Visualizer]
vim.keymap.set("n", "<leader>w", vim.cmd.WhichKey) -- Which-key [Key Bindings]
vim.keymap.set("n", "<leader>z", vim.cmd.ZenMode) -- Zen-mode [Distraction free]

-- Motion
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Center the screen when scroll down
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Center the screen when scroll up
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format) -- Format the current buffer according to the lsp rule
vim.keymap.set("n", "J", "mzJ`z") -- Join current line to the below one
vim.keymap.set("i", "<C-c>", "<Esc>") -- Remap <Escape> to <ctrl+c> in Insert mode

-- Personnal
vim.keymap.set("n", "<leader>n", vim.cmd.Ex) -- Back to File Navigation mode
vim.keymap.set("n", "<leader>cl", vim.cmd.noh) -- Clear highlights
