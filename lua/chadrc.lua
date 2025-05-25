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
    Win0 =     { fg = "black", bg = "#ff797c" }, -- #8b39ba
    Win1 =     { fg = "black", bg = "#ffd35f" },
    Win2 =     { fg = "black", bg = "#a1d34e" },
    Win3 =     { fg = "black", bg = "#469acf" },
    Win4 =     { fg = "black", bg = "#876da8" },
    Win5 =     { fg = "black", bg = "#6da97e" },
    Win6 =     { fg = "black", bg = "#42d4f4" },
    Win7 =     { fg = "black", bg = "#e282c8" },
    Win0sep =  { fg = "#ff797c", bg = "black"  }, -- #8b39ba
    Win1sep =  { fg = "#ffd35f", bg = "black"  }, --
    Win2sep =  { fg = "#a1d34e", bg = "black"  },
    Win3sep =  { fg = "#469acf", bg = "black"  },
    Win4sep =  { fg = "#876da8", bg = "black"  },
    Win5sep =  { fg = "#6da97e", bg = "black"  },
    Win6sep =  { fg = "#42d4f4", bg = "black"  },
    Win7sep =  { fg = "#e282c8", bg = "black"  },
    Win0txt =  { fg = "#ff797c", bg = "#292626"  }, -- #8b39ba
    Win1txt =  { fg = "#ffd35f", bg = "#292626"  }, --
    Win2txt =  { fg = "#a1d34e", bg = "#292626"  },
    Win3txt =  { fg = "#469acf", bg = "#292626"  },
    Win4txt =  { fg = "#876da8", bg = "#292626"  },
    Win5txt =  { fg = "#6da97e", bg = "#292626"  },
    Win6txt =  { fg = "#42d4f4", bg = "#292626"  },
    Win7txt =  { fg = "#e282c8", bg = "#292626"  },

  },
  -- "bearded-arc" solarized_osaka flexoki everblush
  theme_toggle = { "flexoki", "rxyhn" },
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
