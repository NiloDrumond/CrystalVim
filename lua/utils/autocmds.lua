local pwk = require('plugins.ui.which-key');

vim.api.nvim_create_autocmd("FileType", { pattern = "spectre_panel",
  callback = function() pwk.attach_spectre(0) end })
