return {
  {
    "folke/which-key.nvim",
    init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    end,
    opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    },
  },
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
  -- -- Easy motion
  {
   'Lokaltog/vim-easymotion',
  },
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
  -- surround stuff with quotes etc
  {
    'tpope/vim-surround',
  },
  -- A bunch of useful mappings for moving between comments, etc c[
  -- TODO Checkout https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bracketed.md
  {
   'tpope/vim-unimpaired',
  },
  -- Git support
  {
    'tpope/vim-fugitive',
  },
  -- Colorschemes
  {
    'rafi/awesome-vim-colorschemes',
  },
  -- LuaSnip snippet engine
  -- use({"L3MON4D3/LuaSnip",
  --   -- follow latest release.
  --   tag = "v1.*",
  --   -- install jsregexp (optional!:).
  --   run = "make install_jsregexp",
  --   dependencies = { "rafamadriz/friendly-snippets" },
  -- })
  -- TODO Replace with LuaSnip
  -- Airline
  {
    'bling/vim-airline'
  },
  -- Markdown preview
  {
    'shime/vim-livedown',
  },
  -- Github Copilot
  {
    "github/copilot.vim",
    branch = 'release',
  },
}


