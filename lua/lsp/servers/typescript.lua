require("typescript").setup({
  go_to_source_definition = {
    fallback = true, -- fall back to standard LSP definition on failure
  },
})
