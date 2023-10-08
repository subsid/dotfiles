-- M = {
--   'nvim-telescope/telescope.nvim', tag = '0.1.2',
--   dependencies = { 'nvim-lua/plenary.nvim' },
--   config = function()
--     local actions = require("telescope.actions")

--     require("telescope").setup({
--       defaults = {
--       -- Default configuration for telescope goes here:
--       -- config_key = value,
--         mappings = {
--           i = {
--             -- map actions.which_key to <C-h> (default: <C-/>)
--             -- actions.which_key shows the mappings for your picker,
--             -- e.g. git_{create, delete, ...}_branch for the git_branches picker
--             ["<C-h>"] = "which_key",
--             ["<esc>"] = actions.close,
--             ["<C-k>"] = actions.move_selection_previous,
--             ["<C-j>"] = actions.move_selection_next,
--           }
--         }
--       },
--       pickers = {
--         -- Default configuration for builtin pickers goes here:
--         -- picker_name = {
--         --   picker_config_key = value,
--         --   ...
--         -- }
--         -- Now the picker_config_key will be applied every time you call this
--         -- builtin picker
--       },
--       extensions = {
--         -- Your extension configuration goes here:
--         -- extension_name = {
--         --   extension_config_key = value,
--         -- }
--         -- please take a look at the readme of the extension you want to configure
--       }
--     })
--   end
-- }


-- M.project_files = function()
--   local search_dir = vim.fn.input("Enter current directory: ")
--   local opts = {
--     cwd = search_dir
--   } -- define here if you want to define something
--   vim.fn.system('git rev-parse --is-inside-work-tree')
--   if vim.v.shell_error == 0 then
--     require"telescope.builtin".git_files(opts)
--   else
--     require"telescope.builtin".find_files(opts)
--   end
-- end

return {}

