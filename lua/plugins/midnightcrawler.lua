return {
	"zuberol/midnightcrawler.nvim",
	dev = true,
	enabled = true,
	lazy = false, -- todo: use opts
	-- dir = '~/projects/nvim/midnightcrawler.nvim',
	config = function()
		vim.cmd.colorscheme("midnightcrawler")
	end
}
