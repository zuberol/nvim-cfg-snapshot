if not vim.g.zeauberg.ls then
	return
end

local ls_windows_opts = {
	desc = "list windows",
	force = true
}
local function ls_windows()
	local win_infos = vim.fn.getwininfo()
	for _, w in ipairs(win_infos) do
		vim.print(vim.inspect(w))
	end
end
vim.api.nvim_create_user_command('LsWindows', ls_windows, ls_windows_opts)

local ls_buffers_opts = {
	desc = "list buffers",
	force = true
}
local function list_buffers()
	local buffers = vim.fn.getbufinfo()
	for _, b in ipairs(buffers) do
		vim.print(vim.inspect(b))
	end
end
vim.api.nvim_create_user_command('LsBuffers', list_buffers, ls_buffers_opts)
vim.print("ls")
