
local function ismath()
  return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
end

local function no_ismath()
  return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
end


-- set a higher priority (defaults to 0 for most snippets)
local snippets = {
  snippets = {
      { trig = "pci", name = "parencite", condition = no_ismath, priority = 10, body = "\\parencite{$1}$0" }
  },
  autosnippets = {
      { trig = "bf", name = "mathbf", condition = ismath, priority = 10, body = "\\mathbf{$1}$0" },
      { trig = "ptl", name = "partial", condition = ismath, priority = 10, body = "\\partial " },
  }
}

return snippets

