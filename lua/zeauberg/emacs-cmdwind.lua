vim.keymap.set('c', '<C-a>', '<Home>', { desc = "beginning of the line" })

vim.keymap.set('c', '<C-e>', function()
  local pum_active = vim.fn.pumvisible() == 1
	if pum_active then
		return "<C-e>"
	end
	return "<End>"
end,  { desc = "end of the line or cancel pum", expr = true })

vim.keymap.set('c', '<Tab>', function()
  local pum_active = vim.fn.pumvisible() == 1
	if pum_active then
		return "<C-y>"
	end

	local wc = vim.opt.wildcharm:get()
	assert(wc == 9, "without that, ^I is inserted")
	return "<Tab>"
end,  { desc = "wat", expr = true })

vim.keymap.set('c', '<C-b>', '<Left>', { desc = "one char left" })
vim.keymap.set('c', '<C-f>', '<Right>', { desc = "one char right" })
vim.keymap.set('c', '<M-b>', '<S-Left>', { desc = "one word back" })
vim.keymap.set('c', '<M-f>', '<S-Right>', { desc = "one word forward" })
vim.keymap.set('c', '<C-d>', '<Del>', { desc = "delete char before cursor" })
vim.keymap.set('c', '<C-h>', '<C-h>', { desc = "delete char after cursor" })
vim.keymap.set('c', '<M-d>', '<M-f><C-w>', { remap = true, desc = "delete next word" })
vim.keymap.set('c', '<M-h>', '<C-w>', { remap = true, desc = "delete previous word" })
