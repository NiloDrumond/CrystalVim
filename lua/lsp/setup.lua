local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end
local ufo_config = require('plugins.nvim-ufo')

--  ╭──────────────────────────────────────────────────────────╮
--  │ Common                                                   │
--  ╰──────────────────────────────────────────────────────────╯

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
  ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
    { virtual_text = true }),
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
  require('notify')("LSP attached", "info", { title = "LSP", timeout = 2000 })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

--  ╭──────────────────────────────────────────────────────────╮
--  │ Servers                                                  │
--  ╰──────────────────────────────────────────────────────────╯

-- local typescript_ok, typescript = pcall(require, 'typescript')
--
-- if typescript_ok then
--   typescript.setup({
--     disable_commands = false, -- prevent the plugin from creating Vim commands
--     debug = false,            -- enable debug logging for commands
--     go_to_source_definition = {
--       fallback = true,        -- fall back to standard LSP definition on failure
--     },
--     server = {
--       handlers = handlers,
--       on_attach = on_attach,
--       capabilities = capabilities
--     }
--   })
-- end

lspconfig.eslint.setup {
  -- capabilities = capabilities,
  handlers = handlers,
  on_attach = require('lsp.servers.eslint').on_attach,
  settings = require('lsp.servers.eslint').settings,
}

lspconfig.lua_ls.setup {
  handlers = handlers,
  capabilities = capabilities,
  on_attach = on_attach,
  settings = require('lsp.servers.lua_ls').settings
}

lspconfig.jsonls.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  settings = require('lsp.servers.jsonls').settings,
}

lspconfig.gdscript.setup { capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol
.make_client_capabilities()) }

lspconfig.tailwindcss.setup({
  capabilities = require("lsp.servers.tailwindcss").capabilities,
  filetypes = require("lsp.servers.tailwindcss").filetypes,
  handlers = handlers,
  init_options = require("lsp.servers.tailwindcss").init_options,
  on_attach = require("lsp.servers.tailwindcss").on_attach,
  settings = require("lsp.servers.tailwindcss").settings,
})

lspconfig.cssls.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  settings = require("lsp.servers.cssls").settings
}

for _, server in ipairs { "html", "sqlls", "clangd", "graphql", "svelte" } do
  lspconfig[server].setup {
    handlers = handlers,
    on_attach = on_attach,
    capabilities = capabilities
  }
end

vim.api.nvim_create_user_command("Car",
  function(opts)
    vim.cmd("!g++ % && ./a.out " .. opts.args)
  end
  , { nargs = "?" }
)


require('ufo').setup({
  fold_virt_text_handler = ufo_config.handler,
  close_fold_kinds = { "imports" }
})
