local telescope_ok, telescope = pcall(require, 'telescope')

if not telescope_ok then return end

telescope.setup {
  defaults = {
    dynamic_preview_title = true,
    layout_strategy = 'vertical'
  }
}

telescope.load_extension 'fzf'
telescope.load_extension 'packer'

