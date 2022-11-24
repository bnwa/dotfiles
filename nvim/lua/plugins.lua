local fn = vim.fn
local is_directory = require('lib').is_directory
local packer_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_instance = nil

if not is_directory(packer_path) then
  packer_instance = fn.system({'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', packer_path})
end

-- Run `PackerSync` after any change
require('packer').startup(function()
  use { 'wbthomason/packer.nvim' }
  use { 'rafcamlet/nvim-luapad' }
  use { 'tpope/vim-fugitive' }
  use { 'savq/melange' }
  use { "ellisonleao/gruvbox.nvim" }
  use { 'neoclide/coc.nvim', branch = 'release' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
        config = function()
          require 'nvim-treesitter.configs'.setup {
            auto_install = true,
            highlight = { enable = true },
            incremental_selection = { enable = true },
            indentation = { enable = true },
          }
        end
      }
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' },
        config = function()
          require 'telescope'.setup {
            defaults = {
              dynamic_preview_title = true,
              layout_strategy = 'flex'
            }
          }
        end
      }
  use { 'nvim-telescope/telescope-packer.nvim', config = function() require 'telescope'.load_extension 'packer' end }
  use { 'fannheyward/telescope-coc.nvim', config = function() require 'telescope'.load_extension 'coc' end }

  if packer_instance then require('packer').sync() end
end)
