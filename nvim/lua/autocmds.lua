local bo = vim.bo
local new = vim.api.nvim_create_autocmd

new({ 'TermOpen' }, { pattern = '*', callback = function()
  bo.number = false
  bo.relativenumber = false
end })

new({ 'VimEnter' }, { pattern = '*.md', callback = function()
  bo.textwidth = 80
  bo.wrap = true
end })

new({ 'FileType' }, { pattern = '*.fish', callback = function()
  bo.tabstop = 4
  bo.softtabstop = 4
  bo.shiftwidth = 4
end })
