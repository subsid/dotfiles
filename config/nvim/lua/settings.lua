HOME = os.getenv("HOME")

local g = vim.g
local o = vim.o

g.python_highlight_all = 1
g.python3_host_prog='/home/sid/miniconda3/bin/python'

-- Nerdtree ignore
g.NERDTreeIgnore = {'.pyc$'}
g.NERDSpaceDelims=1

-- o.termguicolors = true
o.timeoutlen = 1000
o.updatetime = 200
o.scrolloff = 8
-- o.autochdir = true

-- show matching brackets.
o.showmatch = true

-- case insensitive matching
-- case-sensitive search if any caps
o.ignorecase = true
o.smartcase = true
o.incsearch = true

-- indent a new line the same amount as the line just typed
o.autoindent = true

-- add line numbers
o.number = true
o.numberwidth = 5

-- show a navigable menu for tab completion
o.wildmenu = true
-- o.wildmode = longest,list,full
o.wildignore="log/**,node_modules/**,target/**,tmp/**,*.rbc"

-- history length
o.history = 1000

-- Undo and backup options
o.writebackup = false
o.backup = false
-- o.backupdir = '/tmp/'
o.swapfile = false
-- o.directory = '/tmp/'
o.undodir = os.getenv("HOME") .. '/.undodir'
o.undofile = true

-- set an 80 column border for good coding style
o.cc=80

-- insert mode tab and backspace use 2 spaces
o.softtabstop=2
-- actual tabs occupy 8 characters
o.tabstop=4
-- converts tabs to white space
o.expandtab=true

-- width for autoindents
o.shiftwidth=2
o.showcmd=true

-- always show statusline
o.laststatus=2

-- show trailing whitespace
o.list = true
-- Not sure what is the right way to update this in lua.
vim.cmd([[
    set listchars=tab:▸\ ,trail:▫
]])

-- Improve diff
vim.opt.diffopt:append('linematch:60')

-- show where you are
o.ruler = true

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Preserve view while jumping
o.jumpoptions = 'view'

-- Stable buffer content on window open/close events.
o.splitkeep = 'screen'

-- autocmd BufWinLeave *.* mkview
-- autocmd BufWinEnter *.* silent loadview
vim.cmd([[
  noremap <silent> <leader>V :luafile /home/sid/.config/nvim/init.lua<CR>:filetype detect<CR>:exe ":echo 'neovimrc reloaded'"<CR>
]])

-- fzf
-- vim.cmd([[
--   let g:fzf_preview_window = ['right,60%:sharp']
-- ]])

-- Coc settings
vim.cmd([[
  source $HOME/.config/nvim/plug-config/coc.vim
]])

-- Save and old folds
vim.cmd([[
  set viewoptions-=options
  augroup remember_folds
    autocmd!
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent! loadview
  augroup END
]])

-- vscode colorscheme
vim.cmd([[
  if (&t_Co == 256 || has('gui_running'))
    if ($TERM_PROGRAM == 'iTerm.app')
      colorscheme vscode
    else
      colorscheme  vscode
    endif
  endif
]])

-- Livedown
-- should markdown preview get shown automatically upon opening markdown buffer
g.livedown_autorun = 0
-- the port on which Livedown server will run
g.livedown_port = 1337
-- should the browser window pop-up upon previewing
g.livedown_open = 1


-- Disable syntax highlighting for Large files
vim.cmd([[
  autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif
]])

-- ctag
vim.cmd([[
  set tags^=./.git/tags;
]])
-- tagbar scala support
vim.cmd([[
  let g:tagbar_type_scala = {
      \ 'ctagsbin' : '/home/sid/.local/bin/ctags',
      \ 'ctagstype' : 'scala',
      \ 'sro'       : '.',
      \ 'kinds'     : [
        \ 'p:packages',
        \ 'T:types:1',
        \ 't:traits',
        \ 'o:objects',
        \ 'O:case objects',
        \ 'c:classes',
        \ 'C:case classes',
        \ 'm:methods',
        \ 'V:values:1',
        \ 'v:variables:1'
      \ ]
  \ }
]])

-- Change cursor based on mode
vim.cmd([[
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"

  autocmd BufNewFile,BufReadPost production.php let b:tagbar_ignore = 1
  autocmd BufNewFile,BufReadPost development.php let b:tagbar_ignore = 1
]])

