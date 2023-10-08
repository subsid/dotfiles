function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

map('n', '<leader><leader>f', '<Plug>(easymotion-overwin-f)')

-- Telescope
-- local builtin = require('telescope.builtin')
-- map("n", "<leader>t", require("plugins/telescope").project_files)
-- map("n", "<leader><leader>t", builtin.find_files)

-- NerdTree settings
map('n', '<leader>d', ':NERDTreeToggle<CR>')
map('n', '<leader>f', ':NERDTreeFind<CR>')
map('n', '<leader>]', ':TagbarToggle<CR>')
map('n', '<leader><leader>]', ':TagbarTogglePause<CR>')

-- Navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Save current buffer
map('n', '<leader>w', '<CMD>w<CR>')
-- Source current buffer
map('n', '<leader>s', '<CMD>source %<CR>')

-- exit terminal mode with escape
map('t', 'jj', '<C-\\><C-n>')
map('i', 'jj', '<ESC>')

-- Show message history
map('n', '<leader><leader>m', ':messages<CR>')

-- Toggle search highlight
map('n', '<leader>h', ':set hlsearch<CR>')
map('n', '<leader>n', ':set nohlsearch<CR>')

-- Ripgrep everything
-- map('n', '<leader>a', ':Rg<space>')

vim.cmd([[
command! -bang -nargs=* PRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'dir': system('git -C '.expand('%:p:h').' rev-parse --show-toplevel 2> /dev/null')[:-2], }), <bang>0)

]])

map('n', '<leader>a', ':PRg<space>')
-- map('x', '<leader>a', 'y<Esc>:PRg<space><C-R>')

-- blackhole and paste
map('x', '<leader>p', '"_dP')
vim.cmd([[
  vnoremap <leader>a y<Esc>:PRg<space><C-R>"
]])

-- fzf
-- Show command history
map('n', '<leader><leader>h', ':History:<CR>')
map('n', '<leader><leader>t', ':Files<CR>')
map('n', '<leader>t', '<CMD>GFiles<CR>')
map('n', '<leader>b', '<CMD>Buffers<CR>')

function strip_trailing_whitespaces()
  local view = vim.fn.winsaveview()
  vim.cmd [[keepp %s/\s\+$//e]]
  vim.cmd "update"
  vim.fn.winrestview(view)
end

-- Strip trailing whitespaces
map('n', '<leader><space>', ':lua strip_trailing_whitespaces()<CR>')


-- UndotreeToggle
-- TODO Convert to Lua
map('n', '<leader>u', ':UndotreeToggle<CR>')
vim.cmd([[
  if has("persistent_undo")
     let target_path = expand('~/.undodir')

      " create the directory and any parent directories
      " if the location does not exist.
      if !isdirectory(target_path)
          call mkdir(target_path, "p", 0700)
      endif

      let &undodir=target_path
      set undofile
  endif
]])

function NumberToggle()
  if (vim.o.relativenumber == true) then
    vim.o.relativenumber = false
  else
    vim.o.relativenumber = true
  end
end

function TogglePaste()
  if (vim.o.paste == true) then
    vim.o.paste = false
  else
    vim.o.paste = true
  end
end

-- Toggle relative numbering
map('n', '<leader><leader>r', ':lua NumberToggle()<CR>')
-- Toggle paste mode
map('n', '<leader><leader>p', ':lua TogglePaste()<CR>')
