-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "flexoki",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    -- ["@constructor"] = { fg = "#27e86b"},
    ["@punctuation.bracket"] = { fg = "light_grey" },
    ["@property"] = { fg = "#9b372e" },
    ["@variable"] = { fg = { "light_grey", 17 } },
    -- Special = { fg = "#111111" },
  },
  hl_add = {
    Win0 = { bg = "#ff797c", fg = "black" }, -- #8b39ba
    Win1 = { bg = "#ffd35f", fg = "black" },
    Win2 = { bg = "#a1d34e", fg = "black" },
    Win3 = { bg = "#469acf", fg = "black" },
    Win4 = { bg = "#876da8", fg = "black" },
    Win5 = { bg = "#6da97e", fg = "black" },
    Win6 = { bg = "#42d4f4", fg = "black" },
    Win7 = { bg = "#e282c8", fg = "black" },
    Win0sep = { fg = "#ff797c", bg = "#292626"  }, -- #8b39ba
    Win1sep = { fg = "#ffd35f", bg = "#292626"  }, --
    Win2sep = { fg = "#a1d34e", bg = "#292626"  },
    Win3sep = { fg = "#469acf", bg = "#292626"  },
    Win4sep = { fg = "#876da8", bg = "#292626"  },
    Win5sep = { fg = "#6da97e", bg = "#292626"  },
    Win6sep = { fg = "#42d4f4", bg = "#292626"  },
    Win7sep = { fg = "#e282c8", bg = "#292626"  },
  },
  -- "bearded-arc" solarized_osaka flexoki everblush
  theme_toggle = { "solarized_osaka", "rxyhn" },
}

M.nvdash = { load_on_startup = true }

M.ui = {
  tabufline = {
    lazyload = false,
  },
  cmp = {
    style = "default",
    icons = true,
  },
  statusline = {
    theme = "minimal",
    separator_style = "round",
  },
  telescope = {
    style = "bordered",
  },
}

M.colorify = {
  enabled = true,
  mode = "virtual", -- fg, bg, virtual
  virt_text = "󱓻 ",
  highlight = { hex = true, lspvars = true },
}

M.lsp = {
  signature = true,
}

M.term = {
  float = {
    border = "rounded",
    height = 0.5,
    width = 0.58,
    col = 0.2,
    row = 0.2,
  },
  sizes = {},
}

return M
