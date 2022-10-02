local new_cmd = vim.api.nvim_create_user_command
local notify = vim.notify
local std = require 'lib'
local cmd = vim.cmd
local opt = vim.opt
local fn = vim.fn

local session_path = fn.stdpath('data') .. '/session'

local function toggle_background()
  local current = opt.background:get()
  local next = 'dark' == current and 'light' or 'dark'
  opt.background = next
end

local function persist_session()
  local cwd = fn.getcwd()
  local dir = std.nearest_path_name(cwd)
  cmd('mksession! ' .. session_path ..'/' .. dir .. '.vim')
  notify('Session saved for current directory')
end

local function restore_session(meta)
  local args = meta.fargs 
  local arg = args[1]
  local name = '' ~= arg and arg or std.nearest_path_name(fn.getcwd())
  local session = '' ~= name and session_path .. '/' .. name .. '.vim' or nil

  if not session then return end

  if std.file_readable(session) then
    cmd('source ' .. session)
  else
    notify('No Session to open for this directory - ' .. name .. ' - session file not found at path: ' .. session)
  end
end

new_cmd("Flick", toggle_background, { desc = "Toggle background to opposite of either 'light' or 'dark'" })
new_cmd("Save", persist_session, { desc = "Save project session" })
new_cmd("Open", restore_session, { desc = "Load project session" })
