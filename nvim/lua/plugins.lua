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
  use { "williamboman/mason.nvim",
        config = function()
          require 'mason'.setup {
            ui = {
              border = 'double',
              icons = {
                package_installed = "⦿",
                package_pending = "⦷",
                package_uninstalled = "⦻",
              }
            }
          }
        end
        }
  use { 'williamboman/mason-lspconfig.nvim' }
  use { 'neovim/nvim-lspconfig' }
  use { 'L3MON4D3/LuaSnip' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/nvim-cmp',
        config = function()
          local cmp = require 'cmp'
          local cmp_lsp = require 'cmp_nvim_lsp'
          local lsp_config = require 'lspconfig'
          local mason_config = require 'mason-lspconfig'
          local capabilities = vim.tbl_deep_extend('force',
            {},
            lsp_config.util.default_config.capabilities,
            cmp_lsp.default_capabilities())

          mason_config.setup { automatic_installation = true }
          mason_config.setup_handlers {
            function(lsp_server_name)
              local on_attach = function(client, buf_num)
                vim.diagnostic.config {
                  signs = false,
                  underline = {
                    severity = vim.diagnostic.severity.ERROR
                  }
                }
              end

              require('lspconfig')[lsp_server_name].setup {
                on_attach = on_attach,
                capabilities = capabilities
              }
            end
          }
          cmp.setup {
            snippet = {
              expand = function(args)
                require('luasnip').lsp_expand(args.body)
              end
            },
            mapping = cmp.mapping.preset.insert {
              ['<C-n>'] = cmp.mapping.select_next_item(),
              ['<C-p>'] = cmp.mapping.select_prev_item(),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-y>'] = cmp.mapping.confirm(),
            },
            sources = cmp.config.sources {
              { name = 'nvim_lsp' },
              { name = 'luasnip' },
              {name = 'path' }
            }
          }
        end
      }
  use { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
          require 'nvim-treesitter.configs'.setup {
            auto_install = true,
            highlight = { enable = true },
            incremental_selection = { enable = true },
            indentation = { enable = true },
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
  use { 'nvim-telescope/telescope-packer.nvim',
        config = function() require 'telescope'.load_extension 'packer' end }
  use { 'rafcamlet/nvim-luapad' }
  use { 'tpope/vim-fugitive' }
  use { "ellisonleao/gruvbox.nvim" }
  use { 'savq/melange' }

  if packer_instance then require('packer').sync() end
end)
