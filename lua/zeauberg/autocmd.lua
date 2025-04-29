vim.api.nvim_create_autocmd('BufReadPre', {
	desc = "set path for file under git-root",
	callback = function(_)
		local sys_obj = vim.system({ 'git', 'rev-parse', '--show-toplevel' }, { text = true }):wait()
		if sys_obj.code == 0 then
			local root = string.sub(sys_obj.stdout, 1, -2) -- trim '\n'
			vim.opt_local.path:append(root)
		end
	end
})

-- local rel_numbers_group = vim.api.nvim_create_augroup("zeauberg.rel_numbers", {})
-- vim.api.nvim_create_autocmd("WinEnter", {
-- 	command = "setlocal relativenumber",
-- 	group = rel_numbers_group
-- })
-- vim.api.nvim_create_autocmd("WinLeave", {
-- 	command = "setlocal norelativenumber",
-- 	group = rel_numbers_group
-- })

vim.api.nvim_create_autocmd("StdinReadPost", {
	command = "set nomodified",
	desc = "When reading file from stdin, allow quit nvim without the need to save the buffer."
})

local hide_cursorline_group = vim.api.nvim_create_augroup("zeauberg.hide_cursorline_inactive", {})
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter", "FocusGained" }, {
	command = "setlocal cursorline",
	desc = "hide CursorLine when not focused",
	group = hide_cursorline_group
})
vim.api.nvim_create_autocmd({ "FocusLost", "WinLeave" }, {
	command = "setlocal nocursorline",
	group = hide_cursorline_group
})

vim.api.nvim_create_autocmd("VimLeave", {
	command = 'set guicursor=a:hor80-blinkon250',
	desc = "don't override Alacritty's cursor config, keep in sync with alacritty.conf"
})
