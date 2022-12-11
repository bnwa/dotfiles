local lsp_ok, _ = pcall(require, 'lspconfig')
local cmp_ok, _ = pcall(require, 'cmp_nvim_lsp')

if not lsp_ok or not cmp_ok then return end

require 'plugins.lsp.mason'
require 'plugins.lsp.neodev'
require 'plugins.lsp.setup'
require 'plugins.lsp.fidget'
