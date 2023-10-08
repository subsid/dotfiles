return {
  -- Scala language server
  {
    'scalameta/nvim-metals',
     dependencies = { "nvim-lua/plenary.nvim" }
  },
  -- Autcomplete
  {
    'neoclide/coc.nvim',
    branch = 'release'
  },
  {
    -- fzf is the best
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf', build = ':call fzf#install()' }
  }
}

