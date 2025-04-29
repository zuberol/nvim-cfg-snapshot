if not vim.g.zeauberg.detach then
	return
end

---@param window_id integer | nil
function Detach(window_id)
	if window_id == nil then
		window_id = 0
	end
	local f_width = 150
	local f_height = 50

	local win_conf = vim.api.nvim_win_get_config(window_id)
	vim.print(vim.inspect(win_conf))
	if win_conf.relative == '' then
		assert(#vim.api.nvim_list_uis() == 1, "more that one UI spotted")
		local ui = vim.api.nvim_list_uis()[1]
		local win_conf_override = {
			relative = 'editor',
			width = f_width,
			height = f_height,
			row = (ui.height / 2.0) - (f_height / 2.0),
			col = (ui.width / 2.0) - (f_width / 2.0),
		}

		win_conf = vim.tbl_extend('force', win_conf, win_conf_override)
		win_conf.split = nil
		vim.api.nvim_win_set_config(window_id, win_conf)
	end
end
