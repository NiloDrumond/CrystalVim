local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local header_small_crystal = {
  "",
  "",
  "▄▀▀ █▀█ █ █ ██▀ ▀█▀ ▄▀█ █   █ █ █ █▀▄▀█",
  "▀▄▄ █▀▄  █  ▄▄█  █  █▀█ █▄▄ ▀▄▀ █ █ ▀ █",
  "",
  "",
  "        V I O L E T   N I G H T",
}

local header_crystal = {
  [[ ██████ ██████  ██    ██ ███████ ████████  █████  ██          ██    ██ ██ ███    ███ ]],
  [[██      ██   ██  ██  ██  ██         ██    ██   ██ ██          ██    ██ ██ ████  ████ ]],
  [[██      ██████    ████   ███████    ██    ███████ ██          ██    ██ ██ ██ ████ ██ ]],
  [[██      ██   ██    ██         ██    ██    ██   ██ ██           ██  ██  ██ ██  ██  ██ ]],
  [[ ██████ ██   ██    ██    ███████    ██    ██   ██ ███████       ████   ██ ██      ██ ]],
  [[ ]],
  [[ ]],
  [[                               V I O L E T   N I G H T                               ]]
}


local header_slant = {
  [[   ______                __        ___    ___         ]],
  [[  / ____/______  _______/ /_____ _/ / |  / (_)___ ___ ]],
  [[ / /   / ___/ / / / ___/ __/ __ `/ /| | / / / __ `__ \]],
  [[/ /___/ /  / /_/ (__  ) /_/ /_/ / / | |/ / / / / / / /]],
  [[\____/_/   \__, /____/\__/\__,_/_/  |___/_/_/ /_/ /_/ ]],
  [[          /____/]],
  [[ ]],
  [[                 V I O L E T   N I G H T              ]]
}

local headers = { ansi = header_crystal, slant = header_slant, small = header_small_crystal }


--  ╭──────────────────────────────────────────────────────────╮
--  │ Rainbow Header                                           │
--  ╰──────────────────────────────────────────────────────────╯

-- local function header_chars()
--   math.randomseed(os.time())
--   return headers[math.random(#headers)]
-- end
--
-- -- Map over the headers, setting a different color for each line.
-- -- This is done by setting the Highligh to StartLogoN, where N is the row index.
-- -- Define StartLogo1..StartLogoN to get a nice gradient.
-- local function header_color()
--   local lines = {}
--   for i, line_chars in pairs(header_chars()) do
--     -- local hi = "CrystalHeader"
--     local hi = "CrystalHeader" .. i
--     local line = {
--       type = "text",
--       val = line_chars,
--       opts = {
--         hl = hi,
--         shrink_margin = false,
--         position = "center",
--       },
--     }
--     table.insert(lines, line)
--   end
--
--   local output = {
--     type = "group",
--     val = lines,
--     opts = { position = "center", },
--   }
--
--   return output
-- end

--  ╭──────────────────────────────────────────────────────────╮
--  │ Theta theme                                              │
--  ╰──────────────────────────────────────────────────────────╯
-- originally authored by @AdamWhittingham

local path_ok, plenary_path = pcall(require, "plenary.path")
if not path_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")
local if_nil = vim.F.if_nil
local nwd = require("nvim-web-devicons")

local nvim_web_devicons = {
  enabled = true,
  highlight = true,
}

local function get_extension(fn)
  local match = fn:match("^.+(%..+)$")
  local ext = ""
  if match ~= nil then
    ext = match:sub(2)
  end
  return ext
end

local function icon(fn)
  local ext = get_extension(fn)
  return nwd.get_icon(fn, ext, { default = true })
end

local button_text_width = 50

local function file_button(fn, sc, short_fn, autocd)
  short_fn = short_fn or fn
  local line_icon = sc % 2 == 0 and "-" or "·"
  local ico_txt
  local fb_hl = {}

  if nvim_web_devicons.enabled then
    local ico, hl = icon(fn)
    local hl_option_type = type(nvim_web_devicons.highlight)
    if hl_option_type == "boolean" then
      if hl and nvim_web_devicons.highlight then
        table.insert(fb_hl, { hl, 0, 3 })
      end
    end
    if hl_option_type == "string" then
      table.insert(fb_hl, { nvim_web_devicons.highlight, 0, 3 })
    end
    ico_txt = ico .. "  "
  else
    ico_txt = ""
  end
  local cd_cmd = (autocd and " | cd %:p:h" or "")
  local text = ico_txt .. short_fn .. " "
  text = text .. string.rep(line_icon, button_text_width - #text)
  local file_button_el = dashboard.button(sc, text, "<cmd>e " .. fn .. cd_cmd .. " <CR>")
  local fn_start = short_fn:match(".*[/\\]")
  if fn_start ~= nil then
    table.insert(fb_hl, { "Comment", #ico_txt - 2, #fn_start + #ico_txt })
  end
  file_button_el.opts.hl = fb_hl
  return file_button_el
end

-- local function file_button(fn, sc, short_fn, autocd)
--   short_fn = short_fn or fn
--   local ico_txt
--   local fb_hl = {}
--
--   if nvim_web_devicons.enabled then
--     local ico, hl = icon(fn)
--     local hl_option_type = type(nvim_web_devicons.highlight)
--     if hl_option_type == "boolean" then
--       if hl and nvim_web_devicons.highlight then
--         table.insert(fb_hl, { hl, 3, 8 })
--       end
--     end
--     if hl_option_type == "string" then
--       table.insert(fb_hl, { nvim_web_devicons.highlight, 3, 8 })
--     end
--     WARN: this lines causes a memory leak for some reason
--     ico_txt = "[" .. sc .. "] " .. ico .. "  "
--   else
--     ico_txt = "[" .. sc .. "] "
--   end
--   table.insert(fb_hl, { "CrystalPrimary", 0, 1 })
--   table.insert(fb_hl, { "CrystalSecondary", 1, 2 })
--   table.insert(fb_hl, { "CrystalPrimary", 2, 3 })
--   local cd_cmd = (autocd and " | cd %:p:h" or "")
--   local file_button_el = dashboard.button(sc, ico_txt .. short_fn, "<cmd>e " .. fn .. cd_cmd .. " <CR>")
--   local fn_start = short_fn:match(".*[/\\]")
--   if fn_start ~= nil then
--     table.insert(fb_hl, { "Comment", #ico_txt - 3, #fn_start + #ico_txt })
--   end
--   file_button_el.opts.hl = fb_hl
--   return file_button_el
-- end

local default_mru_ignore = { "gitcommit" }

local mru_opts = {
  ignore = function(path, ext)
    return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
  end,
  autocd = false
}

--- @param start number? optional number
--- @param items_number number? optional number of items to generate, default = 10
local function mru(start, items_number, opts)
  start = if_nil(start, 0)
  local cwd = vim.fn.getcwd()
  opts = opts or mru_opts
  items_number = if_nil(items_number, 10)

  local oldfiles = {}
  for _, v in pairs(vim.v.oldfiles) do
    if #oldfiles == items_number then
      break
    end
    local cwd_cond
    if not cwd then
      cwd_cond = true
    else
      cwd_cond = vim.startswith(v, cwd)
    end
    local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
    if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
      oldfiles[#oldfiles + 1] = v
    end
  end
  local target_width = 35

  local tbl = {}
  for i, fn in ipairs(oldfiles) do
    local short_fn
    if cwd then
      short_fn = vim.fn.fnamemodify(fn, ":.")
    else
      short_fn = vim.fn.fnamemodify(fn, ":~")
    end

    if #short_fn > target_width then
      short_fn = plenary_path.new(short_fn):shorten(1, { -2, -1 })
      if #short_fn > target_width then
        short_fn = plenary_path.new(short_fn):shorten(1, { -1 })
      end
    end

    local shortcut = tostring(i + start - 1)

    local file_button_el = file_button(fn, shortcut, short_fn, opts.autocd)
    tbl[i] = file_button_el
  end
  return {
    type = "group",
    val = tbl,
    opts = {},
  }
end

local header = {
  type = "text",
  val = headers.slant,
  opts = {
    position = "center",
    hl = "CrystalHeader",
  },
}

local section_mru = {
  type = "group",
  val = {
    {
      type = "text",
      val = "Recent files                                     ",
      opts = {
        hl = "CrystalSubtitle",
        shrink_margin = false,
        position = "center",
      },
    },
    { type = "padding", val = 1 },
    {
      type = "group",
      val = function()
        return { mru() }
      end,
      opts = { shrink_margin = false },
    },
  },
}


local buttons = {
  type = "group",
  val = {
    { type = "text", val = "Quick links                                       ",
      opts = { hl = "CrystalSubtitle", position = "center", } },
    { type = "padding", val = 1 },
    dashboard.button("e", "  New file", "<cmd>ene<CR>"),
    dashboard.button("<C-p>", "  Find file"),
    dashboard.button("<S-p>", "  Live grep"),
    dashboard.button("c", "  Configuration", "<cmd>e $XDG_CONFIG_HOME/nvim/lua/plugins.lua<CR>"),
    dashboard.button("u", "  Update plugins", "<cmd>PackerSync<CR>"),
    dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
  },
  position = "center",
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Footer                                                   │
-- ╰──────────────────────────────────────────────────────────╯

local footer = {
  type = "text",
  val = "~ Welcome Home ~",
  opts = {
    position = "center",
    hl = "CrystalFooter",
  }
}

local config = {
  layout = {
    { type = "padding", val = 5 },
    header,
    { type = "padding", val = 3 },
    section_mru,
    { type = "padding", val = 2 },
    buttons,
    { type = "padding", val = 3 },
    footer,
  },
  opts = {
    margin = 5,
    setup = function()
      vim.api.nvim_create_autocmd('DirChanged', {
        pattern = '*',
        callback = function()
          require('alpha').redraw()
        end,
      })
    end,
  },
}

alpha.setup(config)
-- alpha.setup(require('alpha.themes.theta').config)
