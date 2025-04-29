-- navigation
vim.keymap.set('n', '<C-w>t', '<C-w>T', { unique = true })
vim.keymap.set('n', '<A-l>', '<C-w>l', { unique = true })
vim.keymap.set('n', '<A-h>', '<C-w>h', { unique = true })
vim.keymap.set('n', '<A-j>', '<C-w>j', { unique = true })
vim.keymap.set('n', '<A-k>', '<C-w>k', { unique = true })
vim.keymap.set('n', '<A-3>', '<cmd>silent! b#<CR>', { unique = true,desc = 'alternate file'})
vim.keymap.set('n', '<A-]>', '<cmd>silent! bnext<CR>', { unique = true, desc = 'next buffer' })
vim.keymap.set('n', '<A-[>', '<cmd>silent! bprevious<CR>', { unique = true, desc = 'previous buffer' })
vim.keymap.set('n', '<A-9>', '<cmd>silent! last<CR>' , { unique = true, desc = 'last argument'})
vim.keymap.set('n', '<A-0>', '<cmd>silent! first<CR>', { unique = true, desc = 'first argument'})
vim.keymap.set('n', '<A-n>', '<cmd>silent! next<CR>', { unique = true, silent = true, desc = 'next argument'})
vim.keymap.set('n', '<A-N>', '<cmd>silent! previous<CR>', { unique = true, desc = 'previous argument'})
vim.keymap.set('n', '<A-q>', '<cmd>silent! copen<CR>', { unique = true, desc = 'show quickfix'})
vim.keymap.set('n', '<A-w>', '<C-w><C-w>', { unique = true, desc = '"previous" window'})

-- quickfix
vim.keymap.set('n', ']e', '<cmd>silent! cnext<cr>', { unique = true, silent = true, desc = 'next qf entry'})
vim.keymap.set('n', '[e', '<cmd>silent! cprevious<cr>', { unique = true, silent = true, desc = 'previous qf entry'})
vim.keymap.set('n', 'glc', ':lclose<cr>', { unique = true, silent = true, desc = 'close location list' })

-- unused
vim.keymap.set('n', '<A-p>', '<cmd>echo "unused"<cr>', { unique = true, silent = true, desc = 'unused'})

-- newline
vim.keymap.set('n', 'zk', '[<Space>', { unique = true, desc = 'new line up', silent = true, remap = true })
vim.keymap.set('n', 'zj', ']<Space>', { unique = true, desc = 'new line down', silent = true, remap = true })

-- misc
vim.keymap.set('n', '<leader>yp', ':let @*=expand("%:p") | echo @*<CR>', { unique = true, desc = 'yank path', silent = true })

-- tj mapings
vim.keymap.set('t', '<Esc><Esc>', '<c-\\><c-n>', { unique = true, desc = 'exit terminal mode' })
vim.keymap.set('n', '<Esc>', function ()
	vim.cmd.nohlsearch()
	vim.cmd.match("none")
	if vim.snippet.active() then
		vim.snippet.stop()
	end
end, { desc = "actions on <Esc> press", unique = true })

vim.keymap.set('n', '<leader>me', '<cmd>messages<CR>', { unique = true, desc = 'show messages' })

vim.keymap.set('n', 'z<Enter>', 'z<Enter>8<C-Y>', { unique = true, desc = 'z<Enter> +8 space - override' })

vim.keymap.del('x', 'Q')
vim.keymap.set('x', 'Q', '<nop>', { unique = true, desc = "unmap this, not used" })

vim.keymap.set('i', '<C-@>', '<nop>', { unique = false, desc = "override default - insert again previous insert" })

vim.keymap.set('n', 'qq', '<nop>', { unique = true, desc = 'hint: escape macro recording -> "<C-[>"' })
vim.keymap.del("n", "<C-l>")
vim.keymap.del('n', 'gcc')
vim.keymap.del('n', '<C-W>d')
vim.keymap.del( 'n', '<C-W><C-D>')

for i = 1,9 do
	vim.keymap.set('n', "g"..tostring(i), function ()
		assert(vim.fn.exists(":Tab") ~= 0, "missing command")
		vim.cmd.Tab(i)
	end, { unique = true, desc = "go to tab nr " .. i })
end
