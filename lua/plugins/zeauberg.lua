return {
	{
		"ls",
		enabled = true,
		lazy = false,
		opts = {},
		dev = true
	},
	{
		"toggle",
		enabled = true,
		lazy = false,
		dev = true,
		config = function()
			require'toggle_diagnostic'.setup {
				toggle_diagnostic = true,
				hide_on_start = true
			}
			vim.keymap.set("n", "<leader>t", "<cmd>ToggleDiagnostic<cr>", { desc = "Toggle diagnostics", unique = true })
			vim.keymap.set("n", "<leader>T", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, { desc = "Toggle lsp inlay hints", unique = true })
		end
	},
	{
		"snipes.nvim",
		enabled = true,
		lazy = false,
		opts = {},
		dev = true
	}
}
