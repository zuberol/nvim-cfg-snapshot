local M = {
	enum = {
		"buffer",
		"argument",
		"quickfix",
		"loclist",
		"search",
		"diagnostic"
	}
}

Modes = {}

local function next()
	vim.print("next called")
end

local function prev()
	vim.print("prev called")
end

function M.setup(opts)
	Modes.current = opts.initial

	vim.keymap.set("n", "<C-n>", next, { unique = true, desc = "smart next" })
	vim.keymap.set("n", "<C-p>", prev, { unique = true, desc = "smart prev" })
end

return M
