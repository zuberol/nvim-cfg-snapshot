return {
	{
		'nvim-treesitter/nvim-treesitter',
		enabled = true,
		lazy = false,
		build = ':TSUpdate all',
		main = 'nvim-treesitter.configs',
		opts = {
			ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc', 'go', 'json' },
			auto_install = false,
			highlight = {
				enable = true,
				disable = {},
				additional_vim_regex_highlighting = false
			},
			indent = { -- based on '= operator'
				enable = false
			},
			incremental_selection = {
				enable = false,
				keymaps = {
					init_selection = "gnn", -- set to `false` to disable
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
			sync_install = false
		},
	}
}
