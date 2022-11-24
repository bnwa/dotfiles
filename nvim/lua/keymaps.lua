local g = vim.g
local api = vim.api
local cmd = vim.cmd
local extend = vim.tbl_extend
local keymap = vim.keymap.set
local is_directory = require 'lib'.is_directory

local function set(modes, lhs, rhs, opts)
  opts = opts and extend('force', { silent = true }, opts) or { silent = true }
  keymap(modes, lhs, rhs, opts)
end

local function show_git_status()
  cmd 'Git'
end

local function pick_dir_files()
  require('telescope.builtin').find_files {}
end

local function pick_git_files()
  require('telescope.builtin').git_files { 
    show_untracked = true
  }
end

local function pick_help_files()
  require('telescope.builtin').help_tags {}
end

local function pick_packer_plugins()
  require('telescope').extensions.packer.packer {}
end

local function pick_buffer_commits()
  require('telescope.builtin').git_bcommits {}
end

local function pick_file_commits()
  require('telescope.builtin').git_commits {}
end

local function get_lsp_picker(picker)
  return function()
    require('telescope').extensions.coc[picker] {}
  end
end

local function pick_files()
  if is_directory('.git') then
    pick_git_files()
  else
    pick_dir_files()
  end
end

local function pick_register()
  require('telescope.builtin').registers {}
end

g.mapleader = ','

-- Treat wrapped lines as single line
set('n', 'j', 'gj')
set('n', 'k', 'gk')

-- Set terminal to normal mode (note the escape to '\')
set("t", "<leader>l", "<C-\\><C-n>")

-- Reload init.lua on demand
set("n", "<leader>r", ":source $MYVIMRC<CR>", { silent = false })

-- Cease highlighting search matches
set("n", "<leader>k", ":nohlsearch<CR>")

-- Rename symbol
set("n", "<leader>rn", ":call CocActionAsync('rename')<CR>")

-- Show symbol type
set("n", "<space>d", ":call CocAction('doHover')<CR>")

-- Simplify pane switching
-- by default: move cursor down linewise
set("n", "<C-J>", "<C-W><C-J>")
-- by default: unicode digraph insertion
set("n", "<C-K>", "<C-W><C-K>")
-- by default: redraw vim
set("n", "<C-L>", "<C-W><C-L>")
-- by default: move cursor left characterwise
set("n", "<C-H>", "<C-W><C-H>")

-- Telescope
set("n", [[<C-p>]],     pick_files)
set("n", [[<C-g>o]],    pick_buffer_commits)
set("n", [[<C-g>p]],    pick_file_commits)
set("n", [[<C-g>s]],    show_git_status)
set("n", [[<Space>h]],  pick_help_files)
set("n", [[<Space>p]],  pick_packer_plugins)
set("n", [[<Space>e]],  get_lsp_picker('diagnostics'))
set("n", [[<Space>o]],  get_lsp_picker('document_symbols'))
set("n", [[<Space>m]],  get_lsp_picker('commands'))
set("n", [[<Space>a]],  get_lsp_picker('code_actions'))
set("n", [[<Space>wo]], get_lsp_picker('workspace_symbols'))
set("n", [[<Space>fa]], get_lsp_picker('file_code_actions'))
set("n", [[<Space>la]], get_lsp_picker('line_code_actions'))
set("n", [[<Space>gr]], get_lsp_picker('references'))
set("n", [[<Space>gi]], get_lsp_picker('implementations'))
set("n", [[<Space>gd]], get_lsp_picker('definitions'))
set("n", [[<Space>']],  pick_register)
