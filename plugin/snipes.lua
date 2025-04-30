local snipes = {
	tracked_buffers = {},
	buf = nil
}

local dp = vim.fn.stdpath("data") .. "/snipes.db"
assert(type(dp) == "string")

local function load_db()
	snipes.tracked_buffers = {}

	local readable = vim.fn.filereadable(dp) == 1
	if not readable then
		return
	end

	for li in io.lines(dp) do
		table.insert(snipes.tracked_buffers, li)
	end
end

local function write_db()
	local f, err = io.open(dp, "w")
	assert(f ~= nil and err == nil, err)

	for _, l in ipairs(snipes.tracked_buffers) do
		f:write(l.."\n")
	end

	f:flush()
	f:close()
end

local function new_popup(win_opt)
	assert(#vim.api.nvim_list_uis() == 1, "more that one UI spotted")
	local ui = vim.api.nvim_list_uis()[1]

	local win_conf = {
		relative = 'editor',
		width = win_opt.width,
		height = win_opt.height,
		row = (ui.height - win_opt.height) / 2.0,
		col = (ui.width - win_opt.width) / 2.0,
		border = "solid"
	}
	return vim.api.nvim_open_win(win_opt.buff, true, win_conf)
end

function snipes.jump()
	local cursor = vim.api.nvim_win_get_cursor(0)

	local row, _ = cursor[1], cursor[2]
	local bname = snipes.tracked_buffers[row]

	assert(snipes.prev_win ~= nil, "logic error")
	vim.api.nvim_win_call(snipes.prev_win, function ()
		vim.cmd.edit(bname)
	end)
	vim.api.nvim_set_current_win(snipes.prev_win)
end

function snipes.show()
	snipes.buff = vim.api.nvim_create_buf(false, true)

	vim.keymap.set('n', '<C-j>', snipes.jump, { buffer = snipes.buff })
	local function on_exit()
		snipes.tracked_buffers = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), true)
		write_db()
		vim.cmd.quit()
	end
	vim.keymap.set('n', 'go', on_exit, { buffer = snipes.buff, desc = "write changes and quit snipes" } )
	vim.keymap.set('n', '<Esc>', on_exit, { buffer = snipes.buff, desc = "write changes and quit snipes" })

	vim.api.nvim_buf_set_lines(snipes.buff, 0, 1, true, snipes.tracked_buffers)

	snipes.prev_win = vim.api.nvim_get_current_win()

	local _ = new_popup {
		buff = snipes.buff,
		width = 60,
		height = 30
	}
	vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = snipes.buf, scope = 'local' })

	vim.api.nvim_create_autocmd({"BufLeave"}, {
		desc = "autoclose on loosing focus",
		buffer = snipes.buff,
		callback = function (_)
			local w = vim.api.nvim_get_current_win()
			vim.api.nvim_win_close(w, false)
		end,
	})

end

function snipes.toggle_track_file()
	local buff = vim.api.nvim_get_current_buf()
	local bname = vim.api.nvim_buf_get_name(buff)

	for i, f in ipairs(snipes.tracked_buffers) do
		if f == bname then
			table.remove(snipes.tracked_buffers, i)
			return
		end
	end

	table.insert(snipes.tracked_buffers, bname)
end

return {
	setup = function (_)
		load_db()
		vim.keymap.set('n', 'go', snipes.show, { unique = true, desc = "show snipes popup" } )
		vim.keymap.set('n', 'ga', snipes.toggle_track_file, { unique = true, desc = "add buffer to snipes" })
	end
}
