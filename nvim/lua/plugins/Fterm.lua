local fterm_ok, fterm = pcall(require, 'FTerm')

if not fterm_ok then return end

fterm.setup {
  border = 'double'
}
