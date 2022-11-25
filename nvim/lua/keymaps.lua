local g = vim.g
local api = vim.api
local cmd = vim.cmd
local lsp = vim.lsp
local extend = vim.tbl_extend
local keymap = vim.keymap.set
local is_directory = require 'lib'.is_directory

local function set(modes, lhs, rhs, opts)
  opts = opts and extend('force', { silent = true }, opts) or { silent = true }
  keymap(modes, lhs, rhs, opts)
end

local function pick_dir_files()
  require('telescope.builtin').find_files {}
end

local function pick_git_files()
  require('telescope.builtin').git_files {}
end

g.mapleader = ','

-- Treat wrapped lines as single line
set('n', 'j', 'gj')
set('n', 'k', 'gk')

-- [[p]] & [[P]] don't match destination indent, should
-- be default behavior
set("n", "p", "]p")
set("n", "P", "]P")

-- Set terminal to normal mode (note the escape to '\')
set("t", "<leader>l", "<C-\\><C-n>")

-- Reload init.lua on demand
set("n", "<leader>r", ":source $MYVIMRC<CR>", { silent = false })

-- Cease highlighting search matches
set("n", "<leader>k", ":nohlsearch<CR>")

-- Rename symbol
set("n", "<leader>rn", function () vim.lsp.buf.rename() end, {
  desc = "Renames all references to the symbol under the cursor" })

-- Show symbol type
set("n", "<space>d", function () vim.lsp.buf.hover() end, {
  desc = "Displays hover information about the symbol under the cursor in a floating window. Calling the function twice will jump into the floating window" })

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
set("n", [[<C-p>]],     function() if is_directory('.git') then pick_git_files() else pick_dir_files() end end, {
  desc = "List and select from workspace files" })
set("n", [[<C-g>o]],    function() require('telescope.builtin').git_bcommits {} end, {
  desc = "Lists commit history for current buffer file" })
set("n", [[<C-g>p]],    function() require('telescope.builtin').git_commits {} end, {
  desc = "Lists commit history for current workspace repo" })
set("n", [[<C-g>s]],    function() cmd 'Git' end, {
  desc = "Open Fugitive Git status window" })
set("n", [[<Space>h]],  function() require('telescope.builtin').help_tags {} end, {
  desc = "List and select from all available help files" })
set("n", [[<Space>p]],  function() require('telescope').extensions.packer.packer {} end, {
  desc = "List all installed plugins managed by Packer" })
set("n", [[<Space>e]],  function() require('telescope.builtin').diagnostics {} end, {
  desc = "Show diagnostics" })
set("n", [[<Space>o]],  function() require('telescope.builtin').lsp_document_symbols {} end, {
  desc = "Show and query all symbols in current buffer" })
--set("n", [[<Space>m]],  get_lsp_picker('commands'))
set("n", [[<Space>a]],  function() lsp.buf.code_action {} end, {
  desc = "Show native code action UI at cursor position" })
set("n", [[<Space>wo]], function() require('telescope.builtin').lsp_dynamic_workspace_symbols {} end, {
  desc = "Query all symbols in current workspace" })
--set("n", [[<Space>fa]], get_lsp_picker('file_code_actions'))
--set("n", [[<Space>la]], get_lsp_picker('line_code_actions'))
set("n", [[<Space>gr]], function() require('telescope.builtin').lsp_references { jump_type = 'vsplit' } end, {
  desc = "Lists LSP references for word under the cursor, jumps to reference otherwise" })
set("n", [[<Space>gi]], function() require('telescope.builtin').lsp_implementations { jump_type = 'vsplit' } end, {
  desc = "Goto the implementation of the word under the cursor if there's only one, otherwise show all options in Telescope" })
set("n", [[<Space>gd]], function() require('telescope.builtin').lsp_definitions { jump_type = 'vsplit' }end, {
  desc = "Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope" })
set("n", [[<Space>']],  function() require('telescope.builtin').registers {} end, {
  desc = "List all registers and select a register to yank from" })
