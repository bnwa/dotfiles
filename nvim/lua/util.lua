local fn = vim.fn

local M = {}

function M.file_readable(path)
  return 1 == fn.filereadable(path)
end

function M.has_gui()
  return 0 == fn.has('ttyin')
end

function M.is_neovide()
  return 1 == fn.exists('g:neovide')
end

function M.is_directory(path)
  return 1 == fn.isdirectory(path)
end

function M.is_night()
  local date_str = os.date()
  --TODO When day component is single digit, produces a space entry in
  --resulting table so hour entry is at index 5
  local date_parts = vim.split(date_str, '[%s%p]+')
  local date_hour = fn.str2nr(date_parts[4])

  if date_hour > 17 or date_hour < 6 then return true else return false end
end

return M

