local fn = vim.fn
local M = {}

function M.split(str, delimiter)
  return str:gmatch(delimiter .. '([%w%s%-]+)')
end

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

function M.nearest_path_name(abs_path) 
  local nearest_path = ''
  if '/' == abs_path then return nearest_path end
  for path in M.split(abs_path, '/') do nearest_path = path end
  return nearest_path
end

function M.is_night()
  local date_str = os.date()
  local date_parts = vim.split(date_str, '[%s%p]')
  local date_hour = vim.fn.str2nr(date_parts[5])
  if date_hour > 17 then return true else return false end
end

return M
