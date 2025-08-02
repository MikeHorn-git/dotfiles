require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"clangd",
		"nil_ls",
		"pylsp",
		"rust_analyzer",
	},
	automatic_enable = true,
})
