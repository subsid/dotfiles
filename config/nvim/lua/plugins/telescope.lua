M = {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    {
      "nvim-telescope/telescope-frecency.nvim",
      config = function()
        require("telescope").load_extension("frecency")
      end,
      dependencies = { "kkharji/sqlite.lua" },
    },
    { "nvim-lua/plenary.nvim" },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },
    {
      "jonarrien/telescope-cmdline.nvim",
    },
  },
  keys = {
    { ":", "<cmd>Telescope cmdline<cr>", desc = "Cmdline" },
  },
  config = function()
    local actions = require("telescope.actions")

    require("telescope").setup({
      defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        path_display = { "truncate" },
        preview = {
          -- 1MB
          filesize_limit = 1,
        },
        mappings = {
          i = {
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            -- ["<C-h>"] = "which_key",
            ["<esc>"] = actions.close,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          },
        },
      },
      pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
      },
      extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
        frecency = {
          show_scores = false,
          show_unindexed = true,
          ignore_patterns = { "*.git/*", "*/tmp/*" },
          disable_devicons = false,
          workspaces = {
            ["conf"] = "~/.config",
            ["data"] = "~/.local/share",
            ["development"] = "~/development",
            ["workspace"] = "~/workspace",
          },
        },
        cmdline = {
          picker = {
            layout_config = {
              width = 120,
              height = 25,
            },
          },
          mappings = {
            complete = "<Tab>",
            run_selection = "<C-CR>",
            run_input = "<CR>",
          },
        },
      },
    })

    require("telescope").load_extension("cmdline")
  end,
}

return M
