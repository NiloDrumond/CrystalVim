require('tsc').setup({
  auto_open_qflist = true,
  enable_progress_notifications = true,
  flags = "--noEmit",
  hide_progress_notifications_from_history = true,
  spinner = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
})
