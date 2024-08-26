M = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "dockerfile",
        "html",
        "ledger",
        "java",
        "javascript",
        "lua",
        "php",
        "phpdoc",
        "python",
        "query",
        "rust",
        "scala",
        "starlark",
        "vim",
        "vimdoc",
        "zig",
        "markdown",
        "markdown_inline",
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<c-backspace>",
        },
      },
    })
  end,
}

return M
