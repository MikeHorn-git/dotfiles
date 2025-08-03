require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"clangd",
		"lua_ls",
		"nil_ls",
		"pylsp",
		"ruff",
		"rust_analyzer",
	},
	automatic_enable = true,
})
