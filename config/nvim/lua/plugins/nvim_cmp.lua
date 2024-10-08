-- return {
-- Scala language server
-- {
--   'scalameta/nvim-metals',
--    dependencies = { "nvim-lua/plenary.nvim" }
-- },
-- -- Autcomplete
-- {
--   'neoclide/coc.nvim',
--   branch = 'release'
-- },
-- {
--   -- fzf is the best
--   'junegunn/fzf.vim',
--   dependencies = { 'junegunn/fzf', build = ':call fzf#install()' }
-- }
-- }

M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind.nvim",
  },
}

M.config = function()
  local cmp = require("cmp")
  local lspkind = require("lspkind")

  cmp.setup({
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["C-y"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = "gh_issues" },
      { name = "nvim_lua" },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer", keyword_length = 3 },
      { name = "path" },
      {
        name = "cmdline",
        option = {
          ignore_cmds = { "Man", "!" },
        },
      },
    }),
    snippets = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    formatting = {
      format = lspkind.cmp_format({
        with_text = true,
        ellipsis_char = "...",
        menu = {
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          buffer = "[Buffer]",
          nvim_lua = "[Lua]",
          path = "[Path]",
          gh_issues = "[Issues]",
        },
      }),
    },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline({
      ["<C-n>"] = { c = cmp.mapping.select_next_item() },
      ["<C-p>"] = { c = cmp.mapping.select_prev_item() },
    }),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end

return M
