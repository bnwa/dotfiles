local fn = vim.fn
local g = vim.g
local map = vim.api.nvim_set_keymap
local opt = vim.opt
local cmd = vim.cmd

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.isdirectory(fn.glob(install_path)) == 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

opt.background = "light"
opt.expandtab = true
opt.gdefault = true
opt.laststatus = 2
opt.number = true
opt.listchars.precedes = "«"
opt.listchars.extends = "»"
opt.relativenumber = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.shortmess:append "c"
opt.swapfile = false
opt.termguicolors = false
opt.wildignore:append "*/node_modules/*"
opt.wildignore:append "/.git"
opt.wrap = false
opt.writebackup = false
opt.updatetime = 100
opt.visualbell = false

g.mapleader = ","
-- Run `PackerSync` after any change
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-fugitive'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use { 'neoclide/coc.nvim', branch = 'release', run = 'yarn install --frozen-lockfile' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use "fannheyward/telescope-coc.nvim"
end)

require("telescope").load_extension("coc")

require 'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true
  },

  indentation = {
    enable = true
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },

  matchup = {
    enable = true
  }
}

-- TODO update when autcmd can be handled in Lua
cmd([[
  " Markdown
  autocmd BufReadPre *.md Goyo
  
  " JSON(c)
  autocmd FileType tsconfig.json setlocal syntax=jsonc
  
  "Terminal
  autocmd TermOpen * setlocal nonumber norelativenumber
  
  "CSS - Probably don't neede this proper plugin
  "autocmd FileType css setlocal iskeyword+=-
  
  " Fish shell
  autocmd FileType *.fish setlocal tabstop=4
  autocmd FileType *.fish setlocal softtabstop=4
  autocmd FileType *.fish setlocal shiftwidth=4
]])

-- See https://github.com/neoclide/coc.nvim/wiki/F.A.Q#bad-background-highlight-of-floating-window
cmd([[
  hi CocFloating guibg=none guifg=none
]])

-- Treat wrapped lines as single line
map('n', 'j', 'gj', { noremap = true })
map('n', 'k', 'gk', { noremap = true })

-- Set terminal to normal mode (note the escape to '\')
map("t", "<leader>l", "<C-\\><C-n>", { noremap = true })

-- Reload init.lua on demand
map("n", "<leader>r", ":source $MYVIMRC<CR>", { noremap = true })

-- Cease highlighting search matches
map("n", "<leader>k", ":nohlsearch<CR>", { noremap = true })

-- Rename symbol
map("n", "<leader>rn", ":call CocActionAsync('rename')<CR>", { noremap = true })

-- Show symbol type
map("n", "<space>d", ":call CocAction('doHover')<CR>", { noremap = true })

-- Simplify pane switching
map("n", "<C-J>", "<C-W><C-J>", { noremap = true })
map("n", "<C-K>", "<C-W><C-K>", { noremap = true })
map("n", "<C-L>", "<C-W><C-L>", { noremap = true })
map("n", "<C-H>", "<C-W><C-H>", { noremap = true })

-- Telescope
-- map("n", "<Space>a", "<cmd>lua require('telescope.builtin').find_files{}<CR>", { noremap = true })
map("n", "<C-p>", "<cmd>lua require('telescope.builtin').git_files{}<CR>", { noremap = true })
map("n", "<Space>h", "<cmd>lua require('telescope.builtin').help_tags{}<CR>", { noremap = true })
map("n", "<Space>e", "<cmd>lua require('telescope').extensions.coc.diagnostics{}<CR>", { noremap = true })
map("n", "<Space>o", "<cmd>lua require('telescope').extensions.coc.document_symbols{}<CR>", { noremap = true })
map("n", "<Space>m", "<cmd>lua require('telescope').extensions.coc.commands{}<CR>", { noremap = true })
map("n", "<Space>wo", "<cmd>lua require('telescope').extensions.coc.workspace_symbols{}<CR>", { noremap = true })
map("n", "<Space>a", "<cmd>lua require('telescope').extensions.coc.code_actions{}<CR>", { noremap = true })
map("n", "<Space>fa", "<cmd>lua require('telescope').extensions.coc.file_code_actions{}<CR>", { noremap = true })
map("n", "<Space>la", "<cmd>lua require('telescope').extensions.coc.line_code_actions{}<CR>", { noremap = true })
map("n", "<Space>gr", "<cmd>lua require('telescope').extensions.coc.references{}<CR>", { noremap = true })
map("n", "<Space>gi", "<cmd>lua require('telescope').extensions.coc.implementations{}<CR>", { noremap = true })
map("n", "<Space>gd", "<cmd>lua require('telescope').extensions.coc.definitions{}<CR>", { noremap = true })
