local fn = vim.fn
local g = vim.g
local map = vim.api.nvim_set_keymap
local opt = vim.opt

local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
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

require "paq" {
  "savq/paq-nvim";
  "tpope/vim-fugitive";
  "nvim-lua/plenary.nvim";
  "nvim-telescope/telescope.nvim";
  "fannheyward/telescope-coc.nvim";
  { "neoclide/coc.nvim", branch = "release" };
  { "nvim-treesitter/nvim-treesitter", branch = "0.5-compat", run = ":TSUpdate" };
}

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
vim.cmd([[
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

-- Treat wrapped lines as single line
map('n', 'j', 'gj', { noremap = true })
map('n', 'k', 'gk', { noremap = true })

-- Set terminal to normal mode (note the escape to '\')
map("t", "<leader>l", "<C-\\><C-n>", { noremap = true })

-- Reload init.lua on demand
map("n", "<leader>r", ":source $MYVIMRC<CR>", { noremap = true })

-- Cease highlighting search matches
map("n", "<leader>k", ":nohlsearch<CR>", { noremap = true })

-- Simplify pane switching
map("n", "<C-J>", "<C-W><C-J>", { noremap = true })
map("n", "<C-K>", "<C-W><C-K>", { noremap = true })
map("n", "<C-L>", "<C-W><C-L>", { noremap = true })
map("n", "<C-H>", "<C-W><C-H>", { noremap = true })

-- Telescope
map("n", "<C-F>f", "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap = true })
map("n", "<C-F>g", "<cmd>lua require('telescope.builtin').git_files()<CR>", { noremap = true })
map("n", "<C-F>h", "<cmd>lua require('telescope.builtin').help_tags()<CR>", { noremap = true })
map("n", "<C-F>d", "<cmd>lua require('telescope').extensions.coc.diagnostics()<CR>", { noremap = true })
