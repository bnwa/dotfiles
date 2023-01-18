local fn = vim.fn
local util = require 'util'
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

local home_path = os.getenv 'HOME'

local sdkman_root = home_path .. '/.sdkman'
local sdkman_java_11 = sdkman_root .. '/candidates/java/11.0.17-zulu'

local oracle_jre_root = '/Library/Java/JavaVirtualMachines'
local oracle_java_8 = oracle_jre_root .. '/jdk1.8.0_331.jdk/Contents/Home'

local runtimes = {}
-- Java 11 projects require jdtls@0.57.0
if util.is_directory(sdkman_java_11) then table.insert(runtimes, { name = 'JavaSE-11', path = sdkman_java_11 }) end
if util.is_directory(oracle_java_8) then table.insert(runtimes, { name = 'JavaSE-1.8', path = oracle_java_8 }) end


if not util.is_directory(workspace_root) then fn.mkdir(workspace_root, 'p') end

local config = {}
config.capabilities = capabilities
config.flags = {
  allow_incremental_sync = true
}
config.init_options = {
  extended_capabilities = jdtls.extendedClientCapabilities
}
config.init_options.extended_capabilities.resolveAdditionalTextEditsSupport = true
config.on_attach = function(client, bufnr)
  require('jdtls.setup').add_commands()
end
config.settings = {
  java = {
    configuration = { runtimes = runtimes, },
    completion = {
      favoriteStaticMembers = {
        "org.junit.Assert.*",
        "org.junit.Assume.*",
        "org.junit.jupiter.api.Assertions.*",
        "org.junit.jupiter.api.Assumptions.*",
        "org.junit.jupiter.api.DynamicContainer.*",
        "org.junit.jupiter.api.DynamicTest.*",
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*"
      },
    },
    signatureHelp = { enabled = true }
  },
}
config.root_dir = project_root
config.cmd = {
  'java',
  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  '-Dosgi.bundles.defaultStartLevel=4',
  '-Declipse.product=org.eclipse.jdt.ls.core.product',
  '-Dlog.protocol=true',
  '-Dlog.level=ALL',
  '-Xms1g', -- Set initial Java process heap size
  '-Xmx2g', -- Set max Java process heap size
  '--add-modules=ALL-SYSTEM',
  '--add-opens', 'java.base/java.util=ALL-UNNAMED',
  '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
  '-jar', vim.fn.glob(vim.fn.stdpath('data') .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
  '-configuration', vim.fn.stdpath('data') .. '/mason/packages/jdtls/config_mac',
  '-data', workspace_root .. '/' .. vim.fs.basename(project_root),
}

jdtls.start_or_attach(config)
