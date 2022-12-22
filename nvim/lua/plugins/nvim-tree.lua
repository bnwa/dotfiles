local tree_ok, nvim_tree = pcall(require, 'nvim-tree')

if not tree_ok then return end

nvim_tree.setup {
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    severity = {
      min  = vim.diagnostic.severity.ERROR,
    },
  },
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  sort_by = 'name',
  view = {
    float = {
      enable = true,
    },
  },
}
