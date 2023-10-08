M = {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

M.config = function()
  local conform = require("conform")
  conform.setup({
    formatters_by_ft = {
      -- Executes formatters in order
      python = { "isort", "black" },
      lua = { "stylua" },
      sh = { "shellharden" },
    },
  })

  vim.keymap.set({ "n", "v" }, "<leader>cf", function()
    require("conform").format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    })
  end, { desc = "Format file or range (in visual mode)" })
end

return M
