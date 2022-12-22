local crystal = require("theme.crystal")

return function(hl, c)
  local none = "NONE"

  hl.CrystalVimPrimary = {
    fg = crystal.primary
  }
  hl.CrystalVimSecondary = {
    fg = crystal.secondary
  }

  hl.NvimTreeRootFolder = {
    fg = c.orange
  }

  hl.WhichKeyFloat = {
    bg = c.bg_dark,
    fg = none
  }
  hl.FloatBorder = {
    bg = c.bg_dark,
    fg = crystal.secondary
  }
  -- Alpha
  hl.CrystalHeader = {
    fg = crystal.primary
  }
  hl.CrystalHeaderInfo = {
    fg = crystal.secondary
  }
  hl.CrystalFooter = {
    fg = crystal.secondary
  }

  hl.CursorLineNr = {
    fg = crystal.primary
  }

  hl["@keyword"] = { fg = c.purple }
  hl["@function.macro"] = { fg = c.red }
  hl["@error.json"] = { underline = true }

  hl.VM_Extend = { bg = c.bg_search }
  hl.VM_Cursor = { bg = c.bg_search, underline = true }
  hl.VM_Mono = { fg = c.red, underline = true, bold = true }
  hl.VM_Insert = { sp = c.fg, underline = true }

  --  ╭──────────────────────────────────────────────────────────╮
  --  │   Telescope                                              │
  --  ╰──────────────────────────────────────────────────────────╯
  hl.TelescopeTitle = {
    fg = crystal.primary,
    bold = true
  }
  hl.TelescopeBorder = {
    bg = c.bg_float,
    fg = crystal.secondary
  }


  hl.PackageInfoOutdatedVersion = { fg = c.red, }
  hl.PackageInfoUptodateVersion = { fg = c.green1, }
end
