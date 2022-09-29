local lib = require 'lib'
local nearest_path_name = lib.nearest_path_name
local file_readable = lib.file_readable
local new_cmd = vim.api.nvim_create_user_command
local notify = vim.notify
local cmd = vim.cmd
local opt = vim.opt
local fn = vim.fn

local function toggle_background()
  local current = opt.background:get()
  local next = 'dark' == current and 'light' or 'dark'
  opt.background = next
end

new_cmd("Flick", toggle_background, { desc = "Toggle background to opposite of either 'light' or 'dark'" })
