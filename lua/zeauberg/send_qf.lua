local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"
local from_entry = require'telescope.from_entry'

local function make_qf_entry(entry)
	assert(type(entry.value) == "string", "string expected")
	local qf_entry = {}

	local display = ""
	if type(entry.display) == "function" then
		display = entry:display()
	end

	assert(type(display) == "string", "string expected")
	qf_entry.pattern = "*"..display.."*"
	qf_entry.text = display

	local filename = from_entry.path(entry, false, false)
	assert(type(filename) == "string", "string expected")
	qf_entry.filename = filename

	return qf_entry
end


local function pretty_qf(info)
	local what = {
		id = info.id,
		items = 1
	}
	local qf_items = vim.fn.getqflist(what).items
	local mapped = {}
	for i, v in ipairs(qf_items) do
		mapped[i] = qf_items[i].text or "no text"
	end
	return mapped
end

local function send_selected_to_qf(prompt_bufnr, mode, target)
  local picker = action_state.get_current_picker(prompt_bufnr)

  local qf_entries = {}
  for _, entry in ipairs(picker:get_multi_selection()) do
    table.insert(qf_entries, make_qf_entry(entry))
  end

  local prompt = picker:_get_prompt()
  actions.close(prompt_bufnr)

  vim.api.nvim_exec_autocmds("QuickFixCmdPre", {})
  if target == "loclist" then
    vim.fn.setloclist(picker.original_win_id, qf_entries, mode)
  else
    local qf_title = string.format([[%s (%s)]], picker.prompt_title, prompt)
    vim.fn.setqflist({}, 'a', { items = qf_entries,  quickfixtextfunc = pretty_qf })
    vim.fn.setqflist({}, "a", { title = qf_title })
  end
  vim.api.nvim_exec_autocmds("QuickFixCmdPost", {})
end

return send_selected_to_qf
