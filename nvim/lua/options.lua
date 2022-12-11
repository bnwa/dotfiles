local util = require 'util'
local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

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
opt.splitright = true
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 500
opt.wildignore:append '*/node_modules/*'
opt.wildignore:append '/.git'
opt.winminwidth = 20
opt.winwidth = 180
opt.wrap = false
opt.writebackup = false
opt.undofile = true
opt.updatetime = 100
opt.visualbell = false

if util.has_gui() and util.is_neovide() then
  g.neovide_cursor_animation_length = 0.08
  g.neovide_refresh_rate = 60
  g.neovide_remember_window_size = true
  cmd.cd '~'
end


