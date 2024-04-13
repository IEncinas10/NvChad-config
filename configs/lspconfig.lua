-- Not good :(
-- local on_attach = require("plugins.configs.lspconfig").on_attach
--local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>s', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>ra', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  if (vim.version().minor >= 10) then
    vim.keymap.set('n', '<space>fm', vim.lsp.buf.format, bufopts)
  else
    vim.keymap.set('n', '<space>fm', vim.lsp.buf.formatting, bufopts)
  end
end

lspconfig.verible.setup {
  on_attach = on_attach,
  cmd = {
    "verible-verilog-ls",
    "--rules_config_search",
    -- "--rules_config=/home/ier/HARDCODED_VERIBLE_RULES",
  },
  root_dir = function() return vim.loop.cwd() end
}

lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = require 'cmp_nvim_lsp'.default_capabilities(),
  cmd = {
    "clangd",
    "--background-index",
    "--background-index-priority=low",
    -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
    -- to add more checks, create .clang-tidy file in the root directory
    -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
    "--clang-tidy",
    "--completion-style=detailed",
    "--fallback-style=LLVM",
    "--cross-file-rename",
    "--enable-config",
    "--header-insertion=never",
    "--function-arg-placeholders",
    "--malloc-trim",
    "--all-scopes-completion",
  }
}


lspconfig.digestif.setup {}
--
lspconfig.pyright.setup {}

lspconfig.rust_analyzer.setup{
  on_attach = on_attach,
}
