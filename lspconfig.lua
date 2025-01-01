return {
	"neovim/nvim-lspconfig",
	config = function()
		---------------LSP FOR LUA-----------------
		---------------LSP FOR LUA-----------------
		require("lspconfig").lua_ls.setup({
			on_init = function(client)
				local vim = require("vim")
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						version = "LuaJIT",
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
						},
					},
				})
			end,
			settings = {
				Lua = {},
			},
		})
		---------------LSP FOR LUA-----------------
		---------------LSP FOR LUA-----------------

		---------------LSP FOR BASH-----------------
require'lspconfig'.bashls.setup{}
		---------------LSP FOR BASH-----------------

		---------------LSP FOR TAILWINDCSS-----------------
		require 'lspconfig'.tailwindcss.setup {}
		---------------LSP FOR TAILWINDCSS-----------------

		---------------LSP FOR JS/TS-----------------
		require("lspconfig").ts_ls.setup({})
		---------------LSP FOR JS/TS-----------------

		---------------LSP FOR HTML-----------------
		require("lspconfig").html.setup({})
		---------------LSP FOR HTML-----------------

		---------------LSP FOR CSS-----------------
		require("lspconfig").cssls.setup({})
		---------------LSP FOR CSS-----------------

		---------------LSP FOR Emmet-----------------
		require("lspconfig").emmet_language_server.setup({
			filetypes = {
				"css",
				"eruby",
				"html",
				"javascript",
				"javascriptreact",
				"less",
				"sass",
				"scss",
				"pug",
				"typescriptreact",
			},
			-- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
			-- **Note:** only the options listed in the table are supported.
			init_options = {
				---@type table<string, string>
				includeLanguages = {},
				--- @type string[]
				excludeLanguages = {},
				--- @type string[]
				extensionsPath = {},
				--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
				preferences = {},
				--- @type boolean Defaults to true
				showAbbreviationSuggestions = true,
				--- @type "always" | "never" Defaults to "always"
				showExpandedAbbreviation = "always",
				--- @type boolean Defaults to false
				showSuggestionsAsSnippets = false,
				--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
				syntaxProfiles = {},
				--- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
				variables = {},
			},
		}) ---------------LSP FOR Emmet-----------------
	end,
}
