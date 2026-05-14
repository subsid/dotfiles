return {
  -- Catpuccin colors
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- VSCode colors
  {
    'Mofiqul/vscode.nvim',
  },
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "preservim/nerdtree",
  },
  {
    'mbbill/undotree'
  },
  -- -- Leap - next gen easymotion
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    config = function ()
      local leap = require("leap")
      leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }

      -- Use the traversal keys to repeat the previous motion without
      -- explicitly invoking Leap:
      require('leap.user').set_repeat_keys('<enter>', '<backspace>')

      -- Define a preview filter (skip the middle of aphanumeric words):
      leap.opts.preview_filter = function (ch0, ch1, ch2)
        return not (
          ch1:match('%s') or
          ch0:match('%w') and ch1:match('%w') and ch2:match('%w')
        )
      end

    end
  },
  --  'Lokaltog/vim-easymotion',
  -- },
  {
   'troydm/zoomwintab.vim',
  },
  -- Tagbar
  {
    'majutsushi/tagbar',
  },
  {
    'adelarsq/vim-matchit',
  },
  -- Shows indent levels nicely
  {
    'nathanaelkane/vim-indent-guides',
  },
  -- gc commands for commenting
  {
    'tpope/vim-commentary',
  },
  -- Git support
  {
    'tpope/vim-fugitive',
  },
  {
    'tpope/vim-rhubarb',
  },
  -- Colorschemes
  {
    'rafi/awesome-vim-colorschemes',
  },
  -- Airline
  {
    'bling/vim-airline'
  },
  -- Markdown preview
  {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      build = "cd app && yarn install",
      init = function()
        vim.g.mkdp_filetypes = { "markdown" }
        vim.g.mkdp_auto_close = 0
      end,
      config = function(plugin)
        local routes_path = plugin.dir .. "/app/routes.js"
        if vim.fn.filereadable(routes_path) ~= 1 then
          return
        end

        local routes = table.concat(vim.fn.readfile(routes_path), "\n")
        if routes:find("Refreshable /<bufnr> redirect", 1, true) then
          return
        end

        local redirect_route = [[
// Refreshable /<bufnr> redirect. The client rewrites /page/:number to
// /:number after load, but the server only serves /page/:number by default.
use((req, res, next) => {
  if (/^\/\d+$/.test(req.asPath)) {
    res.statusCode = 302
    res.setHeader('Location', `/page${req.asPath}`)
    return res.end()
  }
  next()
})
]]
        local patched, count = routes:gsub("// /page/:number\n", redirect_route .. "\n// /page/:number\n", 1)
        if count > 0 then
          vim.fn.writefile(vim.split(patched, "\n", { plain = true }), routes_path)
        end
      end,
      ft = { "markdown" },
  },
  -- Github Copilot
  -- {
  --   "github/copilot.vim",
  --   branch = 'release',
  -- },
  -- SudaRead and SudaWrite
  {
    'lambdalisue/suda.vim',
  },
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({})
    end,
  },
}


