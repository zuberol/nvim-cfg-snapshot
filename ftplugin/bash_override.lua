if vim.b.did_ftplugin ~= nil then
	return
else
	vim.b.did_ftplugin = false
end

vim.opt_local.makeprg = "/usr/bin/bash"
vim.keymap.set("n", "<Space><Space>", "<cmd>make %<CR>", { buffer = true, silent = false, unique = true, desc = "exec bash script"})
