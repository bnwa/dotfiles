local fn = vim.fn
local M = {}

function M.file_readable(path)
  return 1 == fn.filereadable(session) and true or false
end

function M.has_gui()
  return 0 == fn.has('ttyin') and true or false
end

function M.is_directory(path)
  return 1 == fn.isdirectory(path) and true or false
end

function M.nearest_path_name(abs_path) 
  local nearest_path = ''
  if '/' == abs_path then return nearest_path end
  for path in split(abs_path, '/') do nearest_path = path end
  return nearest_path
end

return M

