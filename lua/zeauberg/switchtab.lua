local function switch_tab_complete()
	local tcount = vim.fn.tabpagenr('$')
	local ret = {}
	for i = 1, tcount do
		table.insert(ret, tostring(i))
	end
	return ret
end

local function switch_tab(param)
	local n = tonumber(param.args)
	assert(type(n) == "number")
	local handle = vim.api.nvim_tabpage_get_number(n)
	vim.api.nvim_set_current_tabpage(handle)
end

local cmd_opts = {
	force = true,
	desc = 'Open tab nr ...',
	complete = switch_tab_complete,
	nargs = 1
}

vim.api.nvim_create_user_command("Tab", switch_tab, cmd_opts)
