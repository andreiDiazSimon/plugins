return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			format_on_save = {
				timeout_ms = 100, -- Timeout for formatting
				lsp_format = "fallback", -- Use LSP formatter if no dedicated formatter is available
			},
			test = 1,
			formatters_by_ft = {
				-- lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				-- python = { "isort", "black" },
				-- You can customize some of the format options for the filetype (:help conform.format)
				-- rust = { "rustfmt", lsp_format = "fallback" },		-- Conform will run the first available formatter
				-- javascript = { "prettier", "prettierd", stop_after_first = true },
				-- html = { "prettier", "prettierd", stop_after_first = true },
				-- css = { "prettier", "prettierd", stop_after_first = true },
			},
		})
	end,
}
