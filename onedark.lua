return {
	"navarasu/onedark.nvim",
	config = function()
		-- Lua
		require("onedark").setup({
			style = "warmer",
			transparent = true, -- Show/hide background


			-- Change code style ---
			-- Options are italic, bold, underline, none
			-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
			code_style = {
				comments = 'none',
				keywords = 'italic,bold',
				functions = 'italic,bold',
				strings = 'none',
				variables = 'italic,bold'
			},

			-- Lualine options --
			lualine = {
				transparent = true, -- lualine center bar transparency
			},


			-- Plugins Config --
			diagnostics = {
				darker = true, -- darker colors for diagnostic
				undercurl = true, -- use undercurl instead of underline for diagnostics
				background = true, -- use background color for virtual text
			},
			-- Custom Highlights --
			colors = {}, -- Override default colors
			highlights = {}, -- Override highlight groups

		})
		require("onedark").load()
	end,
}
