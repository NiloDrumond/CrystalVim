local lspconfig = require("lspconfig")

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
}




local typescript_ok, typescript = pcall(require, 'typescript')

if typescript_ok then
  typescript.setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
  })
end

lspconfig.eslint.setup {
  -- capabilities = capabilities,
  handlers = handlers,
  on_attach = require('lsp.servers.eslint').on_attach,
  settings = require('lsp.servers.eslint').settings,
}

local function on_attach(client, bufnr)
  -- set up buffer keymaps, etc.
end

-- local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, server in ipairs { "emmet_ls" } do
  lspconfig[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
  }
end
