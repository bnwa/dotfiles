local fn = vim.fn
local is_directory = require('lib').is_directory
local packer_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if not is_directory(packer_path) then
  packer_instance = fn.system({'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', packer_path})
end

-- Run `PackerSync` after any change
require('packer').startup(function()
  use { 'wbthomason/packer.nvim' }
  use { 'rafcamlet/nvim-luapad' }
  use { 'tpope/vim-fugitive' }
  use { 'savq/melange' }
  use { 'neoclide/coc.nvim', branch = 'release', run = 'yarn install --frozen-lockfile' }
  use { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
          require 'nvim-treesitter.configs'.setup {
            highlight = {
              enable = true,
              additional_vim_regex_highlighting = false
            },
            incremental_selection = { enable = true },
            indentation = { enable = true },
            matchup = { enable = true }
          }
        end
      }
  use { 'akinsho/toggleterm.nvim',
        tag = 'v1.*',
        config = function ()
          local toggleterm = require 'toggleterm'
          toggleterm.setup {
            direction = 'float',
            on_open = function(term) vim.cmd 'startinsert!' end
          }
        end
      }
  use { 'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
          require 'telescope'.setup {
            defaults = {
              dynamic_preview_title = true
            }
          }
        end
      }
  use { 'fannheyward/telescope-coc.nvim',
        config = function()
           require 'telescope'.load_extension 'coc'
        end
      }
  use { 'nvim-telescope/telescope-packer.nvim',
        config = function()
           require 'telescope'.load_extension 'packer'
        end
      }

  if packer_instance then require('packer').sync() end
end)