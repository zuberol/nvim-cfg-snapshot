---@diagnostic disable: redefined-local, unused-local
return {
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		enabled = true,
		lazy = false,
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function ()
			require("telescope").load_extension("fzf")
		end
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		enabled = true,
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function ()
					return vim.fn.executable"make" == 1
				end
			},
			{ "nvim-tree/nvim-web-devicons" },
		},
		config = function (opts)
			local search_dirs = { vim.fn.expand("~/.config"), vim.fn.expand("~/Documents/chaos"), vim.fn.expand("~/projects") }
			require"telescope".setup {
				defaults = {
					-- cm'overriden by fzf-native'
					-- generic_sorter = require'telescope.sorters'.get_substr_matcher,
					-- file_sorter = require'telescope.sorters'.get_substr_matcher,
					sorting_strategy = "ascending",
					mappings = {
						i = {
							["<A-q>"] = require"zeauberg.send_qf",
							["<C-Space>"] = require"telescope.actions.layout".toggle_preview,
							["<C-j>"] = require"telescope.actions".file_edit,
							["<C-e>"] = require'zeauberg.telescope'.scroll_one_down(),
							["<C-y>"] = require'zeauberg.telescope'.scroll_one_up(),
						},
						n = {
							["<C-Space>"] = require"telescope.actions.layout".toggle_preview,
							["<C-N>"] = require"telescope.actions".move_selection_next,
							["<C-P>"] = require"telescope.actions".move_selection_previous,
							["<C-j>"] = require"telescope.actions".file_edit,
							["j"] = require"telescope.actions".nop,
							["k"] = require"telescope.actions".nop,
							["<C-e>"] = require'zeauberg.telescope'.scroll_one_down(),
							["<C-y>"] = require'zeauberg.telescope'.scroll_one_up(),
						}
					},
					selection_carret = "->",
					border = true,
					borderchars = {
						preview = { " " },
						prompt = { " " },
						results = { " " },
					},
					preview = {
						hide_on_startup = true,
						treesitter = true,
					},
					cache_picker = {
						num_pickers = 10,
						limit_entries = 1000
					},
					prompt_prefix = ">> ",
					dynamic_preview_title = true,
					results_title = "hehe",
					path_display = require"zeauberg.telescope".shortened,
					wrap_results = true,
					layout_strategy = "vertical",
					layout_config = {
						vertical = {
							prompt_position = "top",
						},
						horizontal = {
							prompt_position = "top",
						},
					},
				},
				pickers = {
					live_grep = {
						search_dirs = search_dirs,
						title = nil,
						max_results = 10000,
						disable_coordinates = false,
						mappings = {
							n = {
								["<C-Space>"] = require"telescope.actions.layout".toggle_preview,
							},
							i = {
								["<C-Space>"] = require"telescope.actions.layout".toggle_preview,
							}
						}
					},
					find_files = {
						search_dirs = search_dirs,
						mappings = {
							i = {
								["<A-n>"] = require'zeauberg.telescope'.new_file_in_dir
							},
						}
					},
					buffers = {
						preview = {
							hide_on_startup = false
						}
					},
					help_tags = {
						mappings = {
							n = {
								["<C-j>"] = require"telescope.actions".file_edit,
								["<C-m>"] = require"telescope.actions".file_edit,
							},
							i = {
								["<C-j>"] = require"telescope.actions".file_edit,
								["<C-m>"] = require"telescope.actions".file_edit,
							}
						}
					}
				},
				extensions = {
					fzf = {
						fuzzy = false, -- cm: use "'" to make it fuzzy
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "respect_case",
					}
				}
			}

			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "help tags", unique = true })
			vim.keymap.set("n", "<leader>re", builtin.resume, { desc = "resume picker", unique = true })

			vim.keymap.set("n", "<leader>gs", builtin.live_grep, { desc = "grep search", unique = true })

			vim.keymap.set("n", "<leader>fa", function ()
				builtin.find_files {
					find_command = { "rg", "--files", "--color", "never", "--sortr=path" },
					layout_strategy = "vertical",
				}
			end, { desc = "find files", unique = true })

			vim.keymap.set("n", "<leader>fs", function ()
				builtin.find_files { cwd = vim.uv.cwd(), search_dirs = {} }
			end, { desc = "find files", unique = true })


			vim.keymap.set("n", "<leader>ls", function ()
				builtin.find_files {
					find_command = { "rg", "--files", "--color", "never", "--sortr=path", "--max-depth", "1" },
					search_dirs = {},
					preview = {
						hide_on_startup = false,
						treesitter = true,
					},
					mirror = true,
					layout_strategy = "horizontal",
				}
			end, { desc = "ls current dir", unique = true })

			vim.keymap.set("n", "<leader>/fa", function ()
				vim.ui.input({ prompt = "search dir: ", completion = "dir" }, function (input)
					if input ~= nil and input ~= "" then
						builtin.find_files { cwd = input, search_dirs = {} }
					end
				end)
			end, { desc = "search files under directory", unique = true })

			vim.keymap.set("n", "<leader>ln", function ()
				builtin.find_files(
					{
						search_dirs = { "~/Documents/chaos/quicknote" },
						preview = { hide_on_startup = true },
						path_display = { "tail" },
						find_command = { "rg", "--files", "--color", "never", "--sortr=path" },
					}
				)
			end, { desc = "list quicknotes", unique = true })
		end
	}
}
