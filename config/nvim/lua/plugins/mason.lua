M = {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "stevearc/conform.nvim",
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
}

M.config = function()
  require("mason").setup()
  require("mason-lspconfig").setup({ })
  require('mason-tool-installer').setup({
    ensure_installed = {
      -- lsp
      "lua_ls",
      "rust_analyzer",
      "pyright",
      "bashls",
      "jdtls",
      -- linters
      "mypy",
      "shellcheck",
      "buildifier",
      "checkstyle",
      -- formatters
      "black",
      "isort",
      "stylua",
      "shellharden",
    },
  })

  require("mason-nvim-dap").setup({
    ensure_installed = { "bzl" },
  })
end

return M
