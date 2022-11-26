local g = vim.g
local ex = vim.api.nvim_command
local fn = vim.fn
local opt = vim.opt
local cmd = vim.cmd
local std = require 'lib'

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
opt.splitbelow = false
opt.splitright = false
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = false
opt.wildignore:append '*/node_modules/*'
opt.wildignore:append '/.git'
opt.wrap = false
opt.writebackup = false
opt.updatetime = 100
opt.visualbell = false

if std.is_night() then
  opt.background = 'dark'
else
  opt.background = 'light'
end

if std.has_gui() and std.is_neovide() then
  g.neovide_cursor_animation_length = 0.08
  g.neovide_refresh_rate = 60
  g.neovide_remember_window_size = true
  opt.termguicolors = true
  ex 'colorscheme melange'
end

