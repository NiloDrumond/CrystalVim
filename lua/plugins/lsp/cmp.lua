local cmp = require('cmp')
local icons = require('icons')
local lspkind = require('lspkind')

local buffer_option = {
  -- Complete from all visible buffers (splits)
  get_bufnrs = function()
    local bufs = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      bufs[vim.api.nvim_win_get_buf(win)] = true
    end
    return vim.tbl_keys(bufs)
  end
}


local source_mapping = {
  npm                     = icons.terminal .. 'NPM',
  nvim_lsp                = icons.code .. 'LSP',
  nvim_lsp_signature_help = icons.func .. 'SIG',
  buffer                  = icons.buffer .. 'BUF',
  nvim_lua                = icons.bomb,
  luasnip                 = icons.snippet .. 'SNP',
  calc                    = icons.calculator,
  path                    = icons.folderOpen2,
  treesitter              = icons.tree,
  zsh                     = icons.terminal .. 'ZSH',
}


cmp.setup({
  snippet = {
    expand = function(args)
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },

  window = {
    completion = cmp.config.window.bordered({
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
    }),
    documentation = cmp.config.window.bordered({
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
    }),
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer', keyword_length = 5, option = buffer_option, max_item_count = 8 },
    { name = 'nvim_lua' },
    { name = 'path' },
  }),

  sorting = {
    comparators = {
      cmp.config.compare.recently_used,
    }
  },

  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.symbolic(vim_item.kind, { with_text = true })
      local menu = source_mapping[entry.source.name]
      local maxwidth = 50

      vim_item.menu = menu
      vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)

      return vim_item
    end
  },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- ╭──────────────────────────────────────────────────────────╮
-- │ Cmdline Setup                                            │
-- ╰──────────────────────────────────────────────────────────╯

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


-- OLD

--
-- local lspkind = require('lspkind')
--
--
-- local cmp_status_ok, cmp = pcall(require, "cmp")
-- if not cmp_status_ok then
--   return
-- end
--
-- local snip_status_ok, luasnip = pcall(require, "luasnip")
-- if not snip_status_ok then
--   return
-- end
--
-- require("luasnip/loaders/from_vscode").lazy_load()
--
-- -- ╭──────────────────────────────────────────────────────────╮
-- -- │ Utils                                                    │
-- -- ╰──────────────────────────────────────────────────────────╯
-- local types = require("cmp.types")
--
-- local check_backspace = function()
--   local col = vim.fn.col "." - 1
--   return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
-- end
--
-- local function deprioritize_snippet_and_text(entry1, entry2)
--   -- if entry1:get_kind() == types.lsp.CompletionItemKind.Text then return false end
--   -- if entry2:get_kind() == types.lsp.CompletionItemKind.Text then return true end
--   if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then return false end
--   if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then return true end
-- end
--
-- -- ╭──────────────────────────────────────────────────────────╮
-- -- │ Setup                                                    │
-- -- ╰──────────────────────────────────────────────────────────╯
-- local source_mapping = {
--   npm                     = icons.terminal .. 'NPM',
--   nvim_lsp                = icons.code .. 'LSP',
--   nvim_lsp_signature_help = icons.func .. 'SIG',
--   buffer                  = icons.buffer .. 'BUF',
--   nvim_lua                = icons.bomb,
--   luasnip                 = icons.snippet .. 'SNP',
--   calc                    = icons.calculator,
--   path                    = icons.folderOpen2,
--   treesitter              = icons.tree,
--   zsh                     = icons.terminal .. 'ZSH',
-- }
--
-- local buffer_option = {
--   -- Complete from all visible buffers (splits)
--   get_bufnrs = function()
--     local bufs = {}
--     for _, win in ipairs(vim.api.nvim_list_wins()) do
--       bufs[vim.api.nvim_win_get_buf(win)] = true
--     end
--     return vim.tbl_keys(bufs)
--   end
-- }
--
--
-- cmp.setup {
--   snippet = {
--     expand = function(args)
--       luasnip.lsp_expand(args.body)
--     end
--   },
--
--   mapping = cmp.mapping.preset.insert({
--     ['<C-k>'] = cmp.mapping.select_prev_item(),
--     ['<C-j>'] = cmp.mapping.select_next_item(),
--     ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-2), { 'i', 'c' }),
--     ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(2), { 'i', 'c' }),
--     ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
--     ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
--     ['<C-e>'] = cmp.mapping {
--       i = cmp.mapping.abort(),
--       c = cmp.mapping.close(),
--     },
--     ['<CR>'] = cmp.mapping.confirm({ select = plugins.completion.select_first_on_enter }),
--     ["<Tab>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expandable() then
--         luasnip.expand()
--       elseif luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--       elseif check_backspace() then
--         fallback()
--       else
--         fallback()
--       end
--     end, {
--       "i",
--       "s",
--     }),
--     ["<S-Tab>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, {
--       "i",
--       "s",
--     }),
--     ["<C-l>"] = cmp.mapping(function(fallback)
--       if luasnip.expandable() then
--         luasnip.expand()
--       elseif luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         fallback()
--       end
--     end, {
--       "i",
--       "s",
--     }),
--     ["<C-h>"] = cmp.mapping(function(fallback)
--       if luasnip.jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, {
--       "i",
--       "s",
--     }),
--   }),
--
--   formatting = {
--     format = function(entry, vim_item)
--       vim_item.kind = lspkind.symbolic(vim_item.kind, { with_text = true })
--       local menu = source_mapping[entry.source.name]
--       local maxwidth = 50
--
--       vim_item.menu = menu
--       vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
--
--       return vim_item
--     end
--   },
--
--   -- You should specify your *installed* sources.
--   sources = {
--     { name = 'nvim_lsp', priority = 10 },
--     { name = 'npm', priority = 9 },
--     { name = 'nvim_lsp_signature_help', priority = 8 },
--     { name = 'luasnip', priority = 7, max_item_count = 8 },
--     { name = 'buffer', priority = 7, keyword_length = 5, option = buffer_option, max_item_count = 8 },
--     { name = 'nvim_lua', priority = 5 },
--     { name = 'path', priority = 4 },
--     { name = 'calc', priority = 3 },
--   },
--
--   sorting = {
--     comparators = {
--       deprioritize_snippet_and_text,
--       -- cmp.config.compare.order,
--       -- cmp.config.compare.exact,
--       -- cmp.config.compare.locality,
--       cmp.config.compare.recently_used,
--       cmp.config.compare.score,
--       -- cmp.config.compare.offset,
--       -- cmp.config.compare.sort_text,
--     },
--   },
--
--   confirm_opts = {
--     behavior = cmp.ConfirmBehavior.Replace,
--     select = false,
--   },
--
--   window = {
--     completion = cmp.config.window.bordered({
--       winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
--     }),
--     documentation = cmp.config.window.bordered({
--       winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
--     }),
--   },
--
--   experimental = {
--     ghost_text = true,
--   },
-- }
--
-- -- ╭──────────────────────────────────────────────────────────╮
-- -- │ Cmdline Setup                                            │
-- -- ╰──────────────────────────────────────────────────────────╯
--
-- -- `/` cmdline setup.
-- cmp.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' }
--   }
-- })
-- -- `:` cmdline setup.
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })
