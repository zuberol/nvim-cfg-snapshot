local function default_lsp_handler(server_name)
	error("handler not defined for server: " .. '"' .. server_name .. '"')
end

local function gopls_handler()
	local settings = {
		autostart = true,
		silent = false,
		single_file_support = true,
		settings = {
			gopls = {
				hoverKind = "FullDocumentation",
				linksInHover = "gopls", -- does it work?
				importShortcut = "Both",
				symbolScope = "all",
				verboseOutput = false,
				diagnosticsTrigger = "Save",
				gofumpt = false,
				usePlaceholders = false,
				matcher = "Fuzzy",           -- completion
				symbolMatcher = "CaseSensitive", -- document search
				staticcheck = false,
				semanticTokens = false,
				experimentalPostfixCompletions = false,
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true
				}
			}
		},
		-- handlers = require'package-doc'
	}
	local ok, blink = pcall(require, "blink.cmp")
	if ok then
		settings.capabilities = blink.get_lsp_capabilities() -- includes the built-in LSP capabilities
	end
	require"lspconfig".gopls.setup(settings)
end

local function lua_ls_handler()
	local lazypath = vim.fn.stdpath"data" .. "/lazy"
	local libraries = vim.fn.expand(lazypath .. "/*/lua", true, true)
	assert(type(libraries) == "table")
	table.insert(libraries, vim.fn.expand("$VIMRUNTIME/lua"))
	table.insert(libraries, vim.fn.stdpath("config") .. "/lua")

	require"lspconfig".lua_ls.setup {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					pathStrict = true
				},
				workspace = {
					checkThirdParty = false,
					library = libraries
				},
				semantic = {
					enable = false
				}
			}
		}
	}
end

local function organize_imports()
	local function filter_organize_imports(code_action)
		return code_action.kind == "source.organizeImports"
	end
	vim.lsp.buf.code_action { apply = true, filter = filter_organize_imports }
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function (ev)
		local telescope = require"telescope.builtin"
		vim.keymap.set("n", "<leader>rn", function () error("use \"grn\" instead") end, { unique = true, buffer = ev.buf, desc = "use grn" })
		vim.keymap.set("n", "<leader>ds", telescope.lsp_dynamic_workspace_symbols, { unique = true, desc = "dynamic workspace symbols", buffer = ev.buf })
		vim.keymap.set("n", "gq", vim.lsp.buf.format, { unique = true, buffer = ev.buf, desc = "code format" })
		vim.keymap.set("n", "<leader>oi", organize_imports, { unique = true, buffer = ev.buf, desc = "organize imports" })
	end
})
vim.api.nvim_create_autocmd("LspDetach", {
	callback = function (ev)
		vim.keymap.del("n", "<leader>rn", { buffer = ev.buf })
		vim.keymap.del("n", "<leader>ds", { buffer = ev.buf })
		vim.keymap.del("n", "<leader>fo", { buffer = ev.buf })
		vim.keymap.del("n", "<leader>oi", { buffer = ev.buf })
	end
})

return {
	{
		"williamboman/mason-lspconfig.nvim",
		enabled = true,
		ft = { "go", "lua" },
		opts = {
			ensure_installed = { "gopls", "lua_ls" },
			automatic_installation = true,
			handlers = {
				default_lsp_handler,
				gopls = gopls_handler,
				lua_ls = lua_ls_handler
			}
		},
		dependencies = {
			"williamboman/mason.nvim",
		}
	},
	{
		"williamboman/mason.nvim",
		enabled = true,
		opts = {}
	},
	{
		"neovim/nvim-lspconfig",
		enabled = true,
		dependencies = {
			"saghen/blink.cmp"
		},
	}
}
