local config_path = vim.fn.stdpath('config') .. '/lua/'
local config_order = { 'plugins', 'options', 'colors', 'commands', 'autocmds', 'keymaps' }

for _,config_file in ipairs(config_order) do
  dofile(config_path .. config_file .. '.lua')
end
