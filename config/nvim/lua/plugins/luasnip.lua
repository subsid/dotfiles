-- LuaSnip snippet engine
M = {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  -- follow latest release.
  version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  config = function()
    local ls = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()

    ls.filetype_extend("php", {"html"})

    ls.config.set_config {
      -- This tells LuaSnip to keep aroudn the last snippet.
      -- You can jump back into it even if you move outside of the selection.
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
    }

    -- ls.add_snippets("all", {
    --     ls.parser.parse_snippet({trig="lf"}, "local $1 = function($2) $0 end"),
    -- })

    vim.keymap.set({"i", "s"}, "<c-k>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        print("Nope")
      end
    end, {silent = true})

    vim.keymap.set({"i", "s"}, "<c-j>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, {silent = true})

    vim.keymap.set({"i", "s"}, "<c-e>", function()
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end)
  end,
}

return M
