local util = require 'util'
local cmd = vim.cmd
local opt = vim.opt

if util.is_night() then
  opt.background = 'dark'
else
  opt.background = 'light'
end


if util.has_gui() and util.is_neovide() then
  cmd.colorscheme 'gruvbox'
end

cmd("hi! link Visual Search")
cmd("hi! link PMenu Search")
cmd("hi! link CocUnusedHighlight Todo")
