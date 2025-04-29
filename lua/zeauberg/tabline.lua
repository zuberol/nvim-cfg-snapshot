local M = {}

--- Renders tab names and git repository information when available
---@return string
function RenderTabLine()
	local tabline = ""
	local numberHandle = {}

	local tabs = vim.api.nvim_list_tabpages()
	for _, handle in ipairs(tabs) do
		local i = vim.api.nvim_tabpage_get_number(handle)
		numberHandle [i] = handle
	end

	local tcurr = vim.fn.tabpagenr()
	local tlen = vim.fn.tabpagenr("$")
	for i = 1, tlen do
		local th = numberHandle [i]
		local cw = vim.api.nvim_tabpage_get_win(th)
		local cb = vim.api.nvim_win_get_buf(cw)
		local bn = vim.api.nvim_buf_get_name(cb)

		if i == tcurr then
			tabline = tabline .. "%#TabLineSel#"
		else
			tabline = tabline .. "%#TabLine#"
		end

		tabline = tabline .. "%" .. i .. "T"

		if bn == "" then
			bn = "<scr>"
		else
			bn = vim.fn.fnamemodify(bn, ":t")
		end
		tabline = tabline .. bn

		tabline = tabline .. "%T"

		if i ~= tlen then
			tabline = tabline .. "%#Keyword#"
			tabline = tabline .. " · "
		end
	end

	local is_git_repo = vim.system({ "git", "status" }, { text = true }):wait().code == 0
	if is_git_repo then
		local j1 = vim.system({ "git", "rev-parse", "--show-toplevel" }, { text = true })
		local j2 = vim.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" }, { text = true })
		local j3 = vim.system({ "git", "rev-parse", "--short", "HEAD" }, { text = true })

		local repo = j1:wait().stdout
		assert(repo ~= nil)
		local repo_head = string.gsub(vim.fs.dirname(repo), "^/home/jzuber", "~")
		local repo_tail = vim.fs.basename(repo)
		local branch = j2:wait().stdout
		local commit = j3:wait().stdout

		tabline = string.gsub( (tabline .. "%#Keyword#" .. " | " .. "%#TabLine#" .. repo_head .. "/" .. "%#Type#" .. repo_tail .. "%#TabLine#" .. " -> " .. branch .. "@" .. commit), "\n", "")
	end

	tabline = tabline .. "%#TabLineFill#"

	return tabline
end

function M.setup(opts)
	vim.opt.showtabline = 2 -- always
	vim.opt.tabline = "%!v:lua.RenderTabLine()"
end

M.setup {}

return M
