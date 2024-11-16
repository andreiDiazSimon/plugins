return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	refresh = {
		statusline = 100,
		tabline = 100,
		winbar = 100,
	},
	config = function()
		-- Eviline config for lualine
		-- Author: shadmansaleh
		-- Credit: glepnir
		local lualine = require("lualine")

		-- Color table for highlights
		-- stylua: ignore
		local colors = {
			bg = "#202328",
			fg = "#bbc2cf",
			yellow = "#ECBE7B",
			cyan = "#008080",
			darkblue = "#081633",
			green = "#98be65",
			orange = "#FF8800",
			violet = "#a9a1e1",
			magenta = "#c678dd",
			blue = "#51afef",
			red = "#ec5f67",
			trans = "#00000000", -- Fully transparent (black with 0 opacity)
			pink = "#ff88cc", -- Matte pink
			white = "#e5e5e5", -- Matte white
			black = "#1c1c1c", -- Matte black
		}

		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}

		-- Config
		local config = {
			options = {
				-- Disable sections and component separators
				disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
				component_separators = "  ",
				section_separators = "",
				theme = "onedark",
				-- theme = {
				--   -- We are going to use lualine_c an lualine_x as left and
				--   -- right section. Both are highlighted by c theme .  So we
				--   -- are just setting default looks o statusline
				--   normal = { c = { fg = colors.fg, bg = colors.trans } },
				--   inactive = { c = { fg = colors.fg, bg = colors.trans } },
				-- },
			},
			sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				-- These will be filled later
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
		}

		-- Inserts a component in lualine_c at left section
		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		-- Inserts a component in lualine_x at right section
		local function ins_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		ins_left({
			-- mode component
			function()
				return ""
			end,
			color = function()
				-- auto change color according to neovims mode
				local mode_color = {
					n = colors.red,
					i = colors.green,
					v = colors.blue,
					["␖"] = colors.blue,
					V = colors.blue,
					c = colors.magenta,
					no = colors.red,
					s = colors.orange,
					S = colors.orange,
					["␓"] = colors.orange,
					ic = colors.yellow,
					R = colors.violet,
					Rv = colors.violet,
					cv = colors.red,
					ce = colors.red,
					r = colors.cyan,
					rm = colors.cyan,
					["r?"] = colors.cyan,
					["!"] = colors.red,
					t = colors.red,
				}
				return { fg = mode_color[vim.fn.mode()] }
			end,
			-- padding = { right = 1 },
		})

		ins_left({
			-- filesize component
			"filesize",
			cond = conditions.buffer_not_empty,
		})

		ins_left({
			"filename",
			file_status = true, -- Displays file status (readonly status, modified status)
			path = 3, -- 0: Just the filename
			-- 1: Relative path
			-- 2: Absolute path
			-- 3: Absolute path, with tilde as the home directory
			-- 4: Filename and parent dir, with tilde as the home directory
			symbols = {
				modified = "[+]", -- Text to show when the file is modified.
				readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
				unnamed = "[No Name]", -- Text to show for unnamed buffers.
				newfile = "[New]", -- Text to show for newly created file before first write
			},
			cond = conditions.buffer_not_empty,
			color = { fg = colors.magenta, gui = "bold" },
		})

		ins_left({
			"branch",
			icon = "",
			color = { fg = colors.violet, gui = "bold" },
		})

		ins_left({
			"diff",
			-- Is it me or the symbol for modified us really weird
			symbols = { added = " ", modified = "󰝤 ", removed = " " },
			diff_color = {
				added = { fg = colors.green },
				modified = { fg = colors.orange },
				removed = { fg = colors.red },
			},
			cond = conditions.hide_in_width,
		})
		ins_left({
			"diagnostics",
			component_separators = {
				right = "", -- No separators for right side
			},
			sources = { "nvim_diagnostic", "coc" },
			symbols = { error = " ", warn = " ", info = " ", hint = "󰋖" },
			colored = true, -- Displays diagnostics status in color if set to true.
			always_visible = true, -- Show diagnostics even if there are none.
			update_in_insert = true, -- Update diagnostics in insert mode.
			diagnostics_color = {
				error = { fg = colors.red },
				warn = { fg = colors.yellow },
				info = { fg = colors.green },
				hint = { fg = colors.blue },
			},
		})

		-- Insert mid section. You can make any number of sections in neovim :)
		-- for lualine it's any number greater then 2
		-- Insert mid section
		ins_left({
			function()
				return "%="
			end,
			separator = "", -- Disable separators for this component
		})
		ins_left({
			"filetype",
			component_separators = {
				left = "",
				right = "", -- No separators for right side
			},
			colored = true, -- Displays filetype icon in color if set to true
			icon_only = false, -- Display only an icon for filetype
			icon = { align = "left" }, -- Display filetype icon on the right hand side
			-- icon =	{'X', align='right'}
			-- Icon string ^ in table is ignored in filetype component
		})
		ins_left({
			-- Lsp server name .
			function()
				local msg = "No Active Lsp"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_active_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end,
			icon = " LSP:",
			color = { fg = "#ffffff", gui = "bold" },
		})

		ins_right({ "location" })
		ins_right({ "selectioncount" })
		ins_right({ "searchcount", maxcount = 999, timeout = 500 })
		ins_right({ "progress", color = { fg = colors.fg, gui = "bold" } })
		-- Add components to right sections
		ins_right({
			"o:encoding", -- option component same as &encoding in viml
			fmt = string.upper, -- I'm not sure why it's upper case either ;)
			cond = conditions.hide_in_width,
			color = { fg = colors.fg, gui = "bold" },
		})

		-- Now don't forget to initialize lualine
		lualine.setup(config)
	end,
}
