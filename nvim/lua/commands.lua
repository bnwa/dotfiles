local lib = require 'lib'
local cmd = vim.cmd
local opt = vim.opt
local fn = vim.fn
local notify = vim.notify
local new_cmd = vim.api.nvim_create_user_command
local nearest_path_name = lib.nearest_path_name
local file_readable = lib.file_readable

local session_path = fn.stdpath('data') .. '/session'

local function persist_session()
  local cwd = fn.getcwd()
  local dir = nearest_path_name(cwd)
  cmd('mksession! ' .. session_path ..'/' .. dir .. '.vim')
  notify('Session saved for current directory')
end

local function restore_session(meta)
  local args = meta.fargs 
  local opt = args[1]
  local name = '' ~= opt and opt or nearest_path_name(fn.getcwd())
  local session = '' ~= name and session_path .. '/' .. name .. '.vim' or nil

  if not session then return end

  if file_readable(session) then
    cmd('source ' .. session)
  else
    notify('No Session to open for this directory - ' .. name .. ' - session file not found at path: ' .. session)
  end
end

function toggle_background()
  local current = opt.background:get()
  local next = 'dark' == current and 'light' or 'dark'
  opt.background = next
end


new_cmd("Flick", toggle_background, { desc = "Toggle background to opposite of either 'light' or 'dark'" })
new_cmd("Open", restore_session, { desc = "Load a session", nargs = '?' })
new_cmd("Save", persist_session, { desc = "Save the current session" })
