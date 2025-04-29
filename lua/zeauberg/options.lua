vim.g.fugitive_no_maps = true
vim.g.no_man_maps = true
vim.g.log = vim.log.levels.WARN
vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'
vim.g.man_hardwrap = 0
vim.g.netrw_winsize = 25
vim.opt.verbose = 0
vim.opt.verbosefile = ''
vim.opt.updatetime = 1000
vim.opt.ignorecase = false
vim.opt.wildignorecase = false
vim.opt.fileignorecase = false
vim.opt.smartcase = false
vim.opt.tagcase = 'ignore'
vim.opt.showmode = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 1
vim.opt.splitright = true
vim.opt.scrolloff = 0
vim.opt.wrapscan = false -- don't cycle on buffer end
vim.opt.swapfile = false
vim.opt.more = true
vim.opt.clipboard = { 'unnamed' }
vim.opt.path:append { vim.fn.expand('~/projects'), vim.fn.expand('~/Documents/chaos') } -- works
vim.opt.hidden = true
vim.opt.cpoptions:remove('a')
vim.opt.cpoptions:append('A') -- after saveas/write use <C-^>
vim.opt.cpoptions:append('c') -- don't jump between lines on search
vim.opt.cpoptions:append('F') -- don't jump between lines on search
vim.opt.cpoptions:remove('f') -- don't jump between lines on search
vim.opt.cpoptions:append('s') -- lazy set buffer options
vim.opt.autowriteall = false
vim.opt.autowrite = false
vim.opt.compatible = false
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.tagrelative = true
vim.opt.shada = "<0,h,'0"
vim.opt.title = true
vim.opt.splitbelow = true
vim.opt.timeout = false
vim.opt.ttimeout = true
vim.opt.listchars:append("space:_")
vim.opt.switchbuf = { "uselast" }
vim.opt.diffexpr = ''
vim.opt.patchexpr = ''
vim.opt.diffopt = { 'internal', 'filler', 'closeoff' }
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = false
vim.opt.showtabline = 1
vim.opt.laststatus = 2
vim.opt.cdhome = false

vim.opt.shadafile='NONE'
vim.opt.signcolumn = "yes:2"

vim.opt.complete = { }
vim.opt.completeitemalign = { "abbr", "menu", "kind" }
vim.opt.completeopt = { "fuzzy", "noselect", "menu" }
vim.opt.pumheight = 15
vim.opt.pumwidth = 15 -- cm!: minimum width, useless

vim.opt.wildmenu = true
vim.opt.wildmode = { "full" }
vim.opt.wildoptions = { "fuzzy", "pum" }
vim.opt.wildcharm = 9 -- 9=<Tab> in ascii

vim.opt.winborder = "none"
vim.opt.tabclose = "uselast"

vim.opt.tags = { "./tags", vim.fn.expand("$VIMRUNTIME/doc/tags") }
local lazypath = vim.fn.stdpath 'data' .. '/lazy'
local paths = vim.fn.expand(lazypath .. '/*/doc/tags', true, true)
assert(type(paths) == "table")
for _, p in pairs(paths) do
	vim.opt.tags:append(p)
end
