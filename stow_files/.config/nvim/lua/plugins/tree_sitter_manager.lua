M = {
  "romus204/tree-sitter-manager.nvim",
  lazy = false,
  config = function()
    local ensure_installed = {
      "bash",
      "go",
      "c",
      "cpp",
      "css",
      "dockerfile",
      "html",
      "xml",
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
    }

    require("tree-sitter-manager").setup({
      ensure_installed = vim.fn.executable("tree-sitter") == 1 and ensure_installed or {},
      auto_install = false,
      highlight = true,
    })
  end,
}

return M
