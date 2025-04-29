local fw_cfg = {
	max_width = 80,
	max_height = 40,
	wrap = true,
}
local au = vim.api.nvim_create_augroup("zeauberg.lsp-float-override", { clear = true })

local function with_linebreak(opts)
	local function set_linebreak(arg)
				local wins = vim.fn.win_findbuf(arg.buf)
			assert(#wins == 1, "not implemented")
			for i, w in ipairs(wins) do
				vim.api.nvim_set_option_value("linebreak", true, { scope = "local", win = w })
			end
	end

	return function (override)
		vim.api.nvim_create_autocmd({"BufWinEnter"}, {
			callback = set_linebreak,
			once = true, pattern = "", group = au, desc = opts.desc
		})
		return opts.cb(vim.tbl_deep_extend('force', fw_cfg, override or {}))
	end
end

vim.lsp.buf.hover = with_linebreak {
	cb = vim.lsp.buf.hover,
	desc = "dirty override linebreak in vim.lsp.buf.hover window"
}

-- cm'configured in blink.nvim'
-- vim.lsp.buf.signature_help = override_float_opts {
-- 	cb = vim.lsp.buf.signature_help,
-- 	desc = "dirty override linebreak in vim.lsp.buf.signature_help window"
-- }
