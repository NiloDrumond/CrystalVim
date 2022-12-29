local lspconfig = require("lspconfig")
local ufo_config = require('plugins.nvim-ufo')

--  ╭──────────────────────────────────────────────────────────╮
--  │ Common                                                   │
--  ╰──────────────────────────────────────────────────────────╯

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
}

local navic = require('nvim-navic')
local function on_attach(client, bufnr)
  -- https://www.reddit.com/r/neovim/comments/soep3h/comment/hwadton/
  if client.name == "tsserver" or client.name == "html" then
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
  end
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

--  ╭──────────────────────────────────────────────────────────╮
--  │ Servers                                                  │
--  ╰──────────────────────────────────────────────────────────╯

local typescript_ok, typescript = pcall(require, 'typescript')

if typescript_ok then
  typescript.setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = {
      fallback = true, -- fall back to standard LSP definition on failure
    },
    server = {
      handlers = handlers,
      on_attach = on_attach,
      capabilities = capabilities
    }
  })
end

lspconfig.eslint.setup {
  -- capabilities = capabilities,
  handlers = handlers,
  on_attach = require('lsp.servers.eslint').on_attach,
  settings = require('lsp.servers.eslint').settings,
}

lspconfig.sumneko_lua.setup {
  handlers = handlers,
  capabilities = capabilities,
  on_attach = on_attach,
  settings = require('lsp.servers.sumneko_lua').settings
}

lspconfig.jsonls.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  settings = require('lsp.servers.jsonls').settings,
}

for _, server in ipairs { "html" } do
  lspconfig[server].setup {
    handlers = handlers,
    capabilities = capabilities
  }
end

require('ufo').setup({
  fold_virt_text_handler = ufo_config.handler,
  close_fold_kinds = { "imports" }
})
