local M = {}

local function scroll(direction, speed)
	return function (prompt_bufnr)
		local previewer = require"telescope.actions.state"
			.get_current_picker(prompt_bufnr).previewer
		previewer:scroll_fn(math.floor(speed * direction))
	end
end
function M.scroll_one_up()
	return scroll(-1, 1)
end

function M.scroll_one_down()
	return scroll(1, 1)
end

function M.new_file_in_dir(prompt)
	local function buffer_dir(path)
		return vim.fs.normalize(vim.fs.abspath(vim.fs.dirname(path)))
	end

	local picker = require"telescope.actions.state".get_current_picker(prompt)
	local entry = picker:get_selection() [1]
	local dir = buffer_dir(entry)

	picker:close_windows()
	vim.ui.input({ prompt = "new: " .. dir .. "/", completion = nil }, function (input)
		if input ~= nil then
			assert(string.match(input, "[^%s]+") ~= nil, "whitespace characters only")
			vim.cmd.edit(dir .. "/" .. input)
		end
	end)
end

function M.shortened(opts, path)
	local longShort = {
		["/home/jzuber/projects/coans"] = "@coans",
		["/home/jzuber/Documents/chaos"] = "@chaos",
		["/home/jzuber/Documents/chaos/quicknote"] = "@quick",
		["/home/jzuber/projects"] = "@project",
		["/home/jzuber/.config"] = "@conf",
	}

	for long, short in pairs(longShort) do
		if string.match(path, "^" .. long) then
			local ret = string.gsub(path, "^" .. long, short, 1)
			return ret
		end
	end

	return path
end

return M
