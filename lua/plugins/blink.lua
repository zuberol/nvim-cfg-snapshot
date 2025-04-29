local function filter_snippets_when_one_active(_, items)
	if vim.snippet.active() then
		return vim.tbl_filter(function (item)
			return item.kind ~= require("blink.cmp.types").CompletionItemKind.Snippet
		end, items)
	end
	return items
end

return {
	{
		"saghen/blink.cmp",
		version = "*",
		enabled = true,
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "none",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<Esc>"] = { "hide", "fallback" },
				["<C-i>"] = {
					function (cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward", "fallback"
				},
				["<C-S-i>"] = { "snippet_backward", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
				["<C-u>"] = { function (cmp) cmp.scroll_documentation_up(1) end, "fallback" },
				["<C-d>"] = { function (cmp) cmp.scroll_documentation_down(1) end, "fallback" },
				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
				kind_icons = {
					--        󰜢 󰆦 󰫧 󰉿
					Method = "󰡱",
					Constructor = "󰡱",
					Function = "󰊕",
					Field = "",
					Property = "",
					Class = "󰘦",
					Struct = "󰘦",
					Interface = "󰅩",
					Module = "",
					Constant = "󰏿",
					Snippet = "",
					Color = "󰏘",
					File = "󰈔",
					Folder = "󰉋",
					Text = "",
					Variable = "x",
					Unit = "u",
					Value = "v",
					TypeParameter = "󰖷",
					Enum = "?",
					EnumMember = "?",
					Keyword = "k",
					Event = "?",
					Reference = "?",
					Operator = "?",
				},
			},
			cmdline = {
				enabled = false,
				keymap = nil, -- inherit from opts.keymap
				completion = {
					menu = {
						auto_show = nil -- inherit from opts.completion.menu
					}
				}
			},
			term = {
				enabled = false,
				keymap = nil, -- inherit from opts.keymap
				completion = {
					menu = {
						auto_show = nil -- inherit from opts.completion.menu
					}
				}
			},
			completion = {
				trigger = {
					show_in_snippet = false, -- don't know if it actually works, rl'filter_snippets_when_one_active'
				},
				keyword = { range = "full" },
				accept = {
					auto_brackets = {
						enabled = true,
						kind_resolution = { enabled = true },
						semantic_token_resolution = {
							enabled = true,
						},
					},
				},
				list = { selection = { preselect = true, auto_insert = false } },
				menu = {
					auto_show = false,
					direction_priority = { "n", "s" },
				},
				documentation = {
					auto_show = false,
					update_delay_ms = 50,
					window = {
						max_width = 60,
						max_height = 15
					},
				},
				ghost_text = {
					enabled = true,
					show_with_selection = true,
					show_without_selection = false,
				},
			},
			signature = {
				enabled = true,
				window = {
					max_width = 80,
					max_height = 50,
					direction_priority = { "n", "s" },
					treesitter_highlighting = true,
					show_documentation = true,
				},
			},
			snippets = { preset = "default" },
			sources = {
				default = {
					"lsp", "path",
					"snippets"
				},
				transform_items = filter_snippets_when_one_active
			},
		},
		opts_extend = { "sources.default" },
	},
}
