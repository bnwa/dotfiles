local cmp_lsp = require 'cmp_nvim_lsp'
local lsp_config = require 'lspconfig'
local mason_config = require 'mason-lspconfig'
local capabilities = vim.tbl_deep_extend('force',
  vim.lsp.protocol.make_client_capabilities(),
  cmp_lsp.default_capabilities())

mason_config.setup {
  automatic_installation = true,
  ensure_installed = {
    'emmet_ls',
    'lemminx',
    'jsonls',
    'lua_ls',
    'tsserver',
  },
}

mason_config.setup_handlers {
  ['lua_ls'] = function()
    local lua_libraries = {}
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')
    table.insert(runtime_path, vim.fn.stdpath 'config')
    table.insert(lua_libraries, vim.fn.expand '$VIMRUNTIME')
    table.insert(lua_libraries, vim.fn.stdpath 'config' )
    for _, path in pairs(vim.fn.expand("~/.local/share/nvim/site/pack/packer/opt/*", false, true)) do
      lua_libraries[path] = true
    end
    for _, path in pairs(vim.fn.expand("~/.local/share/nvim/site/pack/packer/start/*", false, true)) do
      lua_libraries[path] = true
    end
    lsp_config.lua_ls.setup {
      capabilities = capabilities,
      settings = {
        Lua = {
          completion = {
            callSnippet = true
          },
          diagnostics = {
            globals = { 'vim' },
          },
          hint = {
            enable = true
          },
          runtime = {
            version = 'Lua 5.1',
            path = runtime_path,
          },
          workspace = {
            checkThirdParty = false,
            library = lua_libraries,
            maxPreload = 100000,
            preloadFileSize = 100000
          },
          telemetry = { enable = false }
        },
      },
    }
  end,
  ['tsserver'] = function ()
    local ts_lsp = require 'typescript'

    ts_lsp.setup {
      server = {
        capabilities = capabilities
      }
    }
  end,
  ['emmet_ls'] = function()
    lsp_config.emmet_ls.setup {
      capabilities = capabilities,
      filetypes = {
        'css',
        'sass',
        'scss',
        'html',
        'less',
        'javascriptreact',
        'typescriptreact',
      },
    }
  end,
  ['jsonls'] = function()
    lsp_config.jsonls.setup {
      capabilities = capabilities,
    }
  end,
  ['lemminx'] = function()
    lsp_config.lemminx.setup {
      capabilities = capabilities,
    }
  end,
}

vim.diagnostic.config {
  signs = false,
  underline = {
    severity = vim.diagnostic.severity.ERROR
  }
}

