local null_ls = require 'null-ls'

local ts_src = {
  filetypes = { "typescript", "javascript" },
  generator = {
    fn = function (params)
      return {
        { title = "Add Missing Imports", action = function() require('typescript').actions.addMissingImport() end },
        { title = "Organize Imports", action = function() require('typescript').actions.organizeImports() end },
        { title = "Remove Unused Variables", action = function() require('typescript').actions.removeUnused() end },
        { title = "Fix All Issues", action = function() require('typescript').actions.fixAll() end },
        { title = "Rename File", action = function() require('typescript').actions.renameFile() end },
      }
    end,
  },
  method = null_ls.methods.CODE_ACTION,
  name = "Typescript.nvim Integration",
}

null_ls.setup {
  sources = { ts_src }
}



