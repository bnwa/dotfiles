local util = require 'util'
local packer_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local packer_init = false

if not util.is_directory(packer_path) then
  vim.fn.system {'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', packer_path }
  packer_init = vim.v.shell == 0
  if not packer_init then return end
end

local packer = require('packer')
local packer_util = require('packer.util')
local packer_file = vim.fn.stdpath('config') .. '/lua/plugins/init.lua'
local packer_augroup = vim.api.nvim_create_augroup('Packer', { clear = true })

local packer_config = {
  display = {
    open_fn = packer_util.float
  }
}

local packer_plugins = function (use)
  use { 'wbthomason/packer.nvim' }
  -- LSP
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }
  use { 'neovim/nvim-lspconfig' }
  use { 'jose-elias-alvarez/null-ls.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'jose-elias-alvarez/typescript.nvim' }
  use { 'mfussenegger/nvim-jdtls' }
  use { 'folke/neodev.nvim' }
  use { 'j-hui/fidget.nvim' }
  use { 'weilbith/nvim-code-action-menu' }
  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" }
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  -- Snippets
  use { 'L3MON4D3/LuaSnip' }
  -- Autocomplete
  use { 'hrsh7th/nvim-cmp', requires = { 'onsails/lspkind.nvim' } }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
  use { 'hrsh7th/cmp-nvim-lsp-document-symbol' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  -- FS
  use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' } }
  -- Terminal
  use { "akinsho/toggleterm.nvim" }
  -- Additional Behavior
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  use { 'nvim-telescope/telescope-packer.nvim' }
  use { 'folke/which-key.nvim' }
  use { 'tpope/vim-fugitive' }
  use { 'tpope/vim-surround' }
  use { 'rafcamlet/nvim-luapad' }
  use { 'numToStr/Comment.nvim' }
  -- Colorschemes
  use { 'savq/melange' }
  use { 'rose-pine/neovim', as = 'rose-pine' }
  use { 'sainnhe/gruvbox-material' }
  use { 'ellisonleao/gruvbox.nvim' }
  use { 'ramojus/mellifluous.nvim', requires = {'rktjmp/lush.nvim'} }
  if packer_init then packer.sync() end
end

packer.startup({
  packer_plugins,
  config = packer_config
})

vim.api.nvim_create_autocmd('BufWritePost', {
  callback = function()
    vim.cmd.source(packer_file)
    packer.sync()
  end,
  group = packer_augroup,
  pattern = '*/plugins/init.lua',
  desc = 'Run PackerSync whenever plugins spec is edited',
})
