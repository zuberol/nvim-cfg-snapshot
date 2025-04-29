vim.g.loaded_netrwPlugin = true

vim.g.zeauberg = {
	detach = true,
	ls = true,
	qf_text_func = true,
}

require"zeauberg"

local lazypath = vim.fn.stdpath"data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "git@github.com:folke/lazy.nvim.git"
	vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_opts = {
	git = {
		url_format = "git@github.com:%s.git"
	},
	dev = {
		path = "~/projects/nvim",
		fallback = false -- when not found locally, fetch from github
	},
	change_detection = {
		enabled = false,
		notify = false,
	},
	defaults = {
		lazy = true,
		enabled = false
	}
}

require("lazy").setup("plugins", lazy_opts)
