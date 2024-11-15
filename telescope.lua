-- init.lua:
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	-- or                              , branch = '0.1.x',
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
		vim.keymap.set("n", "<leader> ", function()
			builtin.find_files({
				hidden = true,
				no_ignore = true,
			})
		end, { desc = "Telescope find files" })

		local ito = require("telescope").setup({
			defaults = {
				sorting_strategy = "ascending",
				layout_strategy = "cursor",
				layout_config = {
					width = 0.6,
					height = 0.3,
					preview_width = 0.6,
				},
				wrap_results = true,
				prompt_prefix = "Ɛ=> ",
				selection_caret = "Ɛ=> ",
				border = true,
				borderchars = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" },
				path_display = { "absolute" },
				preview = { treesitter = false },
			},
		})
	end,
	dependencies = { "nvim-lua/plenary.nvim" },
}
