-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "bearded-arc",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

M.nvdash = { load_on_startup = true }

M.ui = {
  tabufline = {
    lazyload = false
  },
  cmp = {
    style = "default",
    icons = true,
  },
  statusline = {
    theme = "minimal",
    separator_style = "arrow"
  },
  telescope = {
    style = "bordered"
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
