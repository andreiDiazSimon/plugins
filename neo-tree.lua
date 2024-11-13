return{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    opts = {
 follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
                                          -- instead of relying on nvim autocmd events.
	window = {position = 'current'},
	 filesystem = {
          filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false,
    }},
default_component_configs = {
          container = {
            enable_character_fade = true
          },
          indent = {
            indent_size = 6,
          },
          name = {
            trailing_slash = true,
          },
          file_size = {
            enabled = true,
          },
          type = {
            enabled = true,
          },
          last_modified = {
            enabled = true,
          },
          created = {
            enabled = true,
          },
          symlink_target = {
            enabled = true,
          },
        },
    },
config = function(_, opts)
require('neo-tree').setup(opts)
vim.keymap.set('n', '<leader>e', function()
require'neo-tree.command'.execute{toggle = true }
end,{noremap = true, silent = true})


end 
}
