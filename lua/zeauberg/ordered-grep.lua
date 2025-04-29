local M = {}

local finders = require'telescope.finders'
local pickers = require'telescope.pickers'
local conf = require'telescope.config'.values
local _ = require'telescope.builtin'
local make_entry = require'telescope.make_entry'
local utils = require "telescope.utils"
-- local async_oneshot_finder = require "telescope.finders.async_oneshot_finder"

---@return string[]
local function fetch_loaded_buffers()
	local buffers = vim.fn.getbufinfo()
	local ret = {}
	for _, b in ipairs(buffers) do
		if b.name ~= nil then
			table.insert(ret, b.name)
		end
	end
	return ret
end

---@param str string
---@return string[]?
local function split_whitespace(str)
	local sp = vim.split(str, "%s", {trimempty = true})
	local ret = {}
	for _, s in ipairs(sp) do
		if s ~= '' then
			table.insert(ret, s)
		end
	end
	if #ret == 0 then
		return nil
	end
	return ret
end

---@return string[]?, string[]?
---@param str string
local function split_where_what(str)
	local spl = vim.split(str, '%s~%s', { trimempty = true })
	if #spl == 2 then
		local where = split_whitespace(spl[1])
		local what = split_whitespace(spl[2])
		return nil, nil
	elseif #spl == 1 then
		return nil, split_whitespace(spl[1])
	elseif #spl == 0 then
		return nil, nil
	else
		error("not implemented")
	end
end

---@return string
---@param arr string[]
local function join_whitespace(arr)
	return table.concat(arr, " ")
end

---@param arr string[]
---@return string
local function join_files(arr)
	local joined = ""
	for i, v in ipairs(arr) do
		local curr = "*"..v.."*"
		if i == 1 then
			joined = "**/"..curr
		else
			joined = joined .. "/**/" .. curr
		end
	end
	return joined .. "/**"
end
assert(join_files{"one"} == "**/*one*/**")
assert(join_files{"one", "two"} == "**/*one*/**/*two*/**")

---@param patterns string[]
---@return string
local function join_patterns(patterns)
	local joined = ""
	for i, curr in ipairs(patterns) do
		if i == 1 then
			joined = curr
		else
			joined = joined .. ".*" .. curr
		end
	end
	return joined
end
assert(join_patterns{ "one" } == "one")
assert(join_patterns{ "one", "two" } == "one.*two")

---@param str string?
local function emptyOrNil(str)
	if str == nil then
		return true
	end
	local empty = str:match("^%s*$")
	return empty ~= nil
end

local function expand_dirs(dirs)
	local expanded = {}
	for _, d in ipairs(dirs) do
		table.insert(expanded, vim.fn.expand(d))
	end
	return expanded
end

local function make_cmd(opts)
	local flat = utils.flatten { fetch_loaded_buffers(), opts.search_dirs, }
	local search_dirs = expand_dirs(flat)
	---@param prompt string
	return function (prompt)
		-- local where, what = split_where_what(prompt)
		-- if where == nil then
		-- 	where = {}
		-- end
		-- if what == nil then
		-- 	return nil
		-- end
		--
		-- local cmd = utils.flatten { "/home/jzuber/bin/uber_grep", join_whitespace(where), join_patterns(what), search_dirs }
		if emptyOrNil(prompt) then
			return nil
		end

		prompt = prompt:gsub("/", "\\n")

		vim.cmd("messages clear")
		local cmd = utils.flatten { "uber_grep", prompt, search_dirs }
		vim.print(vim.inspect(cmd))
		return cmd
	end
end

local function entry_maker(data)
	local _, _, filename, lnum, col, text = string.find(data, [[(..-):(%d+):(%d+):(.*)]])
	vim.print(vim.inspect(data))
	return {
		value = data,
		display = data,
		ordinal = data,
		col = tonumber(col),
		lnum = tonumber(lnum)
	}
end

local function make_finder(opts)
	local finder = finders.new_async_job {
		command_generator = make_cmd(opts),
		cwd = opts.cwd,
		entry_maker = entry_maker
		--entry_maker = make_entry.gen_from_vimgrep(opts)
	}
	return finder
end

local function grep(opts)
	local picker_opts = {}
	local picker = pickers.new(picker_opts, {
		prompt_title = "uber grep",
		finder = make_finder(opts),
		debounce = 100,
		sorter = require'telescope.sorters'.empty(),
		previewer = conf.grep_previewer(opts)
	})

	picker:find()
	if opts.prompt ~= nil then
		-- picker.set_prompt(opts.prompt)
	end
end




grep {
	cwd = vim.uv.cwd(),
	search_dirs = { "/usr", "~/Documents/chaos", '~/.config' },
	prompt = "nvim ~ Arch"
}

return M
