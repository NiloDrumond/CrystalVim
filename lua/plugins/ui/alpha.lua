local alpha = require("alpha")
local icons = require("icons")
local if_nil = vim.F.if_nil
local fn = vim.fn
local config_dir = fn.stdpath('config')
local dashboard = require("alpha.themes.dashboard")

-- ╭──────────────────────────────────────────────────────────╮
-- │ Header                                                   │
-- ╰──────────────────────────────────────────────────────────╯

local header = {
  "",
  "",
  "█   █ █ ▄▀█ █ █ █ █▀▄▀█ ",
  "█▄▄ █▄█ █▀█ ▀▄▀ █ █ ▀ █ ",
  "",
  "",
  "  P I N K   N I G H T",
}

dashboard.section.header.type = "text";
dashboard.section.header.val = header;
dashboard.section.header.opts = {
  position = "center",
  hl = "CrystalHeader",
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Heading Info                                             │
-- ╰──────────────────────────────────────────────────────────╯

local thingy = io.popen('echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"')
if thingy == nil then return end
local date = thingy:read("*a")
thingy:close()

local datetime = os.date " %H:%M"

local hi_top_section = {
  type = "text",
  val = "┌──────   Today is " .. date .. " ──────┐",
  opts = {
    position = "center",
    hl = "CrystalHeaderInfo"
  }
}

local hi_middle_section = {
  type = "text",
  val = "│                                    │",
  opts = {
    position = "center",
    hl = "CrystalHeaderInfo"
  }
}

local hi_bottom_section = {
  type = "text",
  val = "└────────────  " .. datetime .. "  ─────────────┘",
  opts = {
    position = "center",
    hl = "CrystalHeaderInfo"
  }
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Buttons                                                  │
-- ╰──────────────────────────────────────────────────────────╯

local leader = "SPC"


--- @param sc string
--- @param txt string
--- @param keybind string optional
--- @param keybind_opts table optional
local function button(sc, txt, keybind, keybind_opts)
  local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

  local opts = {
    position = "center",
    shortcut = sc,
    cursor = 5,
    width = 35,
    align_shortcut = "right",
    hl_shortcut = "CrystalPrimary",
  }
  if keybind then
    keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
    opts.keymap = { "n", sc_, keybind, keybind_opts }
  end

  local function on_press()
    -- local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
    local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
    vim.api.nvim_feedkeys(key, "t", false)
  end

  return {
    type = "button",
    val = txt,
    on_press = on_press,
    opts = opts,
  }
end

dashboard.section.buttons.val = {
  button("<C-P>", icons.fileNoBg .. " " .. "Find File", "<cmd>Telescope find_files<CR>", {}),
  button("<S-P>", icons.t .. " " .. "Find Word", "<cmd>lua require('plugins.telescope.pickers.multi-rg')()<CR>", {}),
  button("SPC s h", icons.fileRecent .. " " .. "Recents", "<cmd>Telescope oldfiles hidden=true<CR>", {}),
  button("SPC / s d", icons.timer .. " " .. "Load Current Dir",
    "<cmd>SessionManager load_current_dir_session<CR>", {}),
  button("SPC / u", icons.container .. " " .. "Update Plugins", "<cmd>PackerSync<CR>", {}),
  button("SPC / i", icons.container .. " " .. "Install Plugins", "<cmd>PackerInstall<CR>", {}),
  button("SPC / c", icons.cog .. " " .. "Settings", "<cmd>e $MYVIMRC<CR>", {}),
  button("-", icons.exit .. " " .. "Exit", "<cmd>exit<CR>", {}),
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Footer                                                   │
-- ╰──────────────────────────────────────────────────────────╯

local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

local function line_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

local function footer()
  local plugins = #vim.tbl_keys(packer_plugins)
  local v = vim.version()
  local ecovim_version = line_from(config_dir .. "/.ecovim.version")
  return string.format(" v%d.%d.%d   %d   %s ", v.major, v.minor, v.patch, plugins, ecovim_version[1])
end

dashboard.section.footer.val = "~ Welcome Home ~"
dashboard.section.footer.opts = {
  position = "center",
  hl = "CrystalFooter",
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup                                                    │
-- ╰──────────────────────────────────────────────────────────╯

local section = {
  header = dashboard.section.header,
  hi_top_section = hi_top_section,
  hi_middle_section = hi_middle_section,
  hi_bottom_section = hi_bottom_section,
  buttons = dashboard.section.buttons,
  footer = dashboard.section.footer,
}

local opts = {
  layout = {
    { type = "padding", val = 5 },
    section.header,
    { type = "padding", val = 1 },
    section.hi_top_section,
    section.hi_middle_section,
    section.hi_bottom_section,
    { type = "padding", val = 2 },
    section.buttons,
    { type = "padding", val = 3 },
    section.footer,
  },
  opts = {
    margin = 5
  },
}

alpha.setup(opts)
