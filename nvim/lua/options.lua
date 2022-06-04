local g = vim.g
local ex = vim.api.nvim_command
local fn = vim.fn
local opt = vim.opt
local has_gui = require 'lib'.has_gui

opt.background = 'light'
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
opt.termguicolors = false
opt.wildignore:append '*/node_modules/*'
opt.wildignore:append '/.git'
opt.wrap = false
opt.writebackup = false
opt.updatetime = 100
opt.visualbell = false

if has_gui() then
  g.neovide_cursor_animation_length = 0.08
  g.neovide_refresh_rate = 60
  g.neovide_remember_window_size = true
  opt.guifont = { 'Liga SFMono Nerd Font', 'SF Mono', 'Menlo' }
  opt.termguicolors = true
  ex 'colorscheme melange'
  ex 'cd ~/Github'
end