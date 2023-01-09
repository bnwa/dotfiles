local fidget = require 'fidget'

fidget.setup {
  sources = {
    -- jdtls not yet fully supported - constant progress updates
    jdtls = {
      ignore = true
    }
  }
}
