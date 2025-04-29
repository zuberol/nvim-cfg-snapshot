if not vim.g.zeauberg.qf_text_func then
	return
end

-- rf'https://github.com/yorickpeterse/nvim-pqf/blob/main/lua/pqf/init.lua#L67'
local function list_items(info)
  if info.quickfix == 1 then
    return vim.fn.getqflist({ id = info.id, items = 1, qfbufnr = 1 })
  else
    return vim.fn.getloclist(info.winid, { id = info.id, items = 1, qfbufnr = 1 })
  end
end

function Customqffunc(data)
	local ret = {}
	local entries = list_items(data)
	for _, en in ipairs(entries.items) do
		local tmp = vim.fn.substitute(en.text, '\n\\s*', ' ', 'g')
		if string.len(tmp) > 60 then
			tmp = string.sub(tmp, 1, 60) .. "..."
		end
		table.insert(ret, tmp)
	end
	return ret
end
vim.opt.quickfixtextfunc = 'v:lua.Customqffunc'
