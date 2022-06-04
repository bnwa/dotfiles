local bo = vim.bo
local wo = vim.wo
local new = vim.api.nvim_create_autocmd

local user = vim.api.nvim_create_augroup('user', { clear = true })

new({ 'TermOpen' }, { pattern = '*', group = user, callback = function()
  wo.number = false
  wo.relativenumber = false
end })

new({ 'VimEnter' }, { pattern = '*.md', group = user, callback = function()
  bo.textwidth = 80
  bo.wrap = true
end })

new({ 'FileType' }, { pattern = '*.fish', group = user, callback = function()
  bo.tabstop = 4
  bo.softtabstop = 4
  bo.shiftwidth = 4
end })
