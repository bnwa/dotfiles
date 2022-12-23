local ok, jdtls = pcall(require, 'jdtls')
local cmp_ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4

if not ok or not cmp_ok then return end

local workspace_root = vim.fn.stdpath('data') .. '/eclipse-jdtls/workspace'
local project_root = jdtls.setup.find_root { 'pom.xml', '.git' }
local capabilities = vim.tbl_deep_extend('force',
  vim.lsp.protocol.make_client_capabilities(),
  cmp_lsp.default_capabilities())
local util = require 'util'
local fn = vim.fn

if not util.is_directory(workspace_root) then fn.mkdir(workspace_root, 'p') end

local config = { capabilities = capabilities }

config.settings = {}
config.init_options = {
  extended_capabilities = jdtls.extendedClientCapabilities
}
config.root_dir = project_root
config.cmd = {
  'java',
  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  '-Dosgi.bundles.defaultStartLevel=4',
  '-Declipse.product=org.eclipse.jdt.ls.core.product',
  '-Dlog.protocol=true',
  '-Dlog.level=ALL',
  '-Xms1g',
  '--add-modules=ALL-SYSTEM',
  '--add-opens', 'java.base/java.util=ALL-UNNAMED',
  '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
  '-jar', vim.fn.glob(vim.fn.stdpath('data') .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
  '-configuration', vim.fn.stdpath('data') .. '/mason/packages/jdtls/config_mac',
  '-data', workspace_root .. '/' .. vim.fs.basename(project_root),
}

jdtls.start_or_attach(config)
