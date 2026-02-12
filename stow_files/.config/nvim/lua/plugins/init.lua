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
    'shime/vim-livedown',
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
}


