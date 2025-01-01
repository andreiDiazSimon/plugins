return {
	"hrsh7th/nvim-cmp",
	config = function()
		local cmp = require("cmp")
		--function called in the mapping = {}
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
					-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),

			}),

			sources = cmp.config.sources({
    { name = "copilot", group_index = 2 },
				{ name = "nvim_lsp" },
				{ name = "vsnip" }, -- For vsnip users.
				-- { name = 'luasnip' }, -- For luasnip users.
				-- { name = 'ultisnips' }, -- For ultisnips users.
				-- { name = 'snippy' }, -- For snippy users.
			}, {
				{ name = "buffer" },
			}),
		})

		-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
		-- Set configuration for specific filetype.
		--[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]
		--

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})

		-- Setup for specific LSP servers
		local capabilities = require("cmp_nvim_lsp").default_capabilities()


		-- Lua BASH configuration
		require("lspconfig")["bashls"].setup({
			capabilities = capabilities,
		})

		-- Lua LSP configuration
		require("lspconfig")["lua_ls"].setup({
			capabilities = capabilities,
		})

		-- JavaScript/TypeScript LSP configuration
		require("lspconfig")["ts_ls"].setup({
			capabilities = capabilities,
		})

		-- Emmet language server setup
		local capabilities_emmet = vim.lsp.protocol.make_client_capabilities()
		capabilities_emmet.textDocument.completion.completionItem.snippetSupport = true
		require("lspconfig").emmet_language_server.setup({
			capabilities = capabilities_emmet,
		})

		-- HTML LSP setup (reuse capabilities)
		require("lspconfig").html.setup({
			capabilities = capabilities_emmet,
		})

		-- CSS LSP setup (reuse capabilities)
		require("lspconfig").cssls.setup({
			capabilities = capabilities_emmet,
		})


		-- TAILWINDCSS LSP setup (reuse capabilities)
		require("lspconfig").tailwindcss.setup({
			capabilities = capabilities,
		})
	end,
}
