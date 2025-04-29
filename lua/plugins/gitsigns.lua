return {
	{
		'lewis6991/gitsigns.nvim',
		version = '1.0.0',
		enabled = true,
		lazy = false,
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '-' },
				topdelete = { text = '-' },
				changedelete = { text = '~' },
				untracked = { text = '?' },
			},
			signs_staged_enable = false,
			signcolumn = true,
			numhl      = false,
			linehl     = false,
			word_diff  = false,
			auto_attach = true,
			attach_to_untracked = true,
			watch_gitdir = {
				follow_files = true
			},
			current_line_blame = false,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = 'eol',
				delay = 0,
				ignore_whitespace = false,
				virt_text_priority = 100,
				use_focus = false, -- ??
			},
			current_line_blame_formatter = '<author> -> <summary>',
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil,
			max_file_length = 40000,
			preview_config = {
				border = 'none',
				style = 'minimal',
				relative = 'cursor',
				row = 0,
				col = 1
			},
		},
	}
}
