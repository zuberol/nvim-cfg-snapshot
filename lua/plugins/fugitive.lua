return {
	"tpope/vim-fugitive",
	enabled = true,
	lazy = false,
	config = function ()
		vim.keymap.set('n', 'gi', '<cmd>G<cr>', { silent = true, unique = true, desc = 'git status, overrides default "gi"' })
	end
}
