local function map(m, k, v, opts)
  vim.keymap.set(m, k, v, opts)
end

map("n", "<leader><leader>f", "<Plug>(easymotion-overwin-f)")

-- Telescope
-- local builtin = require('telescope.builtin')
-- map("n", "<leader>t", require("plugins/telescope").project_files)
-- map("n", "<leader><leader>t", builtin.find_files)

-- NerdTree settings
map("n", "<leader>d", ":NERDTreeToggle<CR>")
map("n", "<leader>f", ":NERDTreeFind<CR>")

-- Aerial settings
map("n", "<leader>]", ":AerialToggle right<CR>")

-- Navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Copilot
map("n", "<leader><leader>cd", ":Copilot disable<CR>")
map("n", "<leader><leader>ce", ":Copilot enable<CR>")
map("n", "<leader><leader>cs", ":Copilot status<CR>")

-- Save current buffer
map("n", "<leader>w", "<CMD>w<CR>")
-- Source current buffer
map("n", "<leader>%", "<CMD>source %<CR>")

-- exit terminal mode with escape
map("t", "jj", "<C-\\><C-n>")
map("i", "jj", "<ESC>")

-- Show message history
map("n", "<leader><leader>m", ":messages<CR>")

-- Toggle search highlight
map("n", "<leader>h", ":set hlsearch<CR>")
map("n", "<leader>n", ":set nohlsearch<CR>")

-- blackhole and paste
map("x", "<leader>p", '"_dP')

function StripTrailingWhitespaces()
  local view = vim.fn.winsaveview()
  vim.cmd([[keepp %s/\s\+$//e]])
  vim.cmd("update")
  vim.fn.winrestview(view)
end

-- Strip trailing whitespaces
map("n", "<leader><space>", ":lua StripTrailingWhitespaces()<CR>")

-- UndotreeToggle
-- TODO Convert to Lua
map("n", "<leader>u", ":UndotreeToggle<CR>")
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
  if vim.o.relativenumber == true then
    vim.o.relativenumber = false
  else
    vim.o.relativenumber = true
  end
end

function TogglePaste()
  if vim.o.paste == true then
    vim.o.paste = false
    -- Automatically gets disabled when toggling from paste mode.
    -- https://stackoverflow.com/questions/37957844/set-expandtab-in-vimrc-not-taking-effect
    vim.o.expandtab = true
  else
    vim.o.paste = true
  end
end

-- Toggle relative numbering
map("n", "<leader><leader>r", ":lua NumberToggle()<CR>")
-- Toggle paste mode
map("n", "<leader><leader>p", ":lua TogglePaste()<CR>")

-- LuaSnip reload
map("n", "<leader>S", ':lua require("plugins.luasnip").config()<CR>')

-- Telescope
local tb = require("telescope.builtin")

function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

local topts = { noremap = true, silent = true }

map("n", "<leader>ts", ":Telescope current_buffer_fuzzy_find<cr>", topts)
map("v", "<leader>ts", function()
  local text = vim.getVisualSelection()
  tb.current_buffer_fuzzy_find({ default_text = text })
end, topts)

-- map("n", "<leader>a", ":Telescope live_grep<cr>", topts)
map("n", "<leader>a", ":Telescope live_grep_args<CR>")
map("n", "<leader>A", ":Telescope live_grep_args search_dirs={vim.fn.expand('%:h')}", topts)
map("v", "<leader>a", function()
  local text = vim.getVisualSelection()
  tb.live_grep({ default_text = text })
end, topts)

map("n", "<leader>sf", ":Telescope find_files<CR>", { desc = "[S]earch [F]iles" })
map(
  "n",
  "<leader><leader>sf",
  ":Telescope find_files no_ignore=true hidden=true search_dirs={vim.fn.expand('%:h')}",
  { desc = "Custom [S]earch [F]iles" }
)
map("n", "<leader>td", ":Telescope lsp_document_symbols<CR>", { desc = "[Search] [D]ocument" })
map("n", "<leader>tw", ":Telescope lsp_workspace_symbols<CR>", { desc = "[W]orkspace [S]ymbols" })
map("n", "<leader>tr", ":Telescope lsp_references<CR>", { desc = "LSP [R]efereces" })
map("n", "<leader>b", tb.buffers, {})
map("n", "<leader>?", "<Cmd>Telescope frecency<CR>")
map("n", "<leader>h", tb.command_history, {})
map("n", "<leader><leader>h", tb.help_tags, {})

