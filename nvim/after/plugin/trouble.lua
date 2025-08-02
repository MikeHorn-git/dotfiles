require("trouble").setup({
	{
		icons = false,
		fold_open = "v", -- icon used for open folds
		fold_closed = ">", -- icon used for closed folds
		indent_lines = false, -- add an indent guide below the fold icons
		signs = {
			-- icons / text used for a diagnostic
			error = "error",
			warning = "warn",
			hint = "hint",
			information = "info",
		},
		use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
	},
})

vim.keymap.set("n", "<leader>xx", function()
	require("trouble").toggle("diagnostics")
end, { desc = "Diagnostics (Trouble)" })

vim.keymap.set("n", "<leader>xX", function()
	require("trouble").toggle("diagnostics", { filter = { buf = 0 } })
end, { desc = "Buffer Diagnostics (Trouble)" })

vim.keymap.set("n", "<leader>cs", function()
	require("trouble").toggle("symbols", { focus = false })
end, { desc = "Symbols (Trouble)" })

vim.keymap.set("n", "<leader>cl", function()
	require("trouble").toggle("lsp", { focus = false, win = { position = "right" } })
end, { desc = "LSP Definitions / references / ... (Trouble)" })

vim.keymap.set("n", "<leader>xL", function()
	require("trouble").toggle("loclist")
end, { desc = "Location List (Trouble)" })

vim.keymap.set("n", "<leader>xQ", function()
	require("trouble").toggle("qflist")
end, { desc = "Quickfix List (Trouble)" })
