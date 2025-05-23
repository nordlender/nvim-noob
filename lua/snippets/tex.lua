
local function in_mathzone()
  return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
end

-- set a higher priority (defaults to 0 for most snippets)
local snippets = {
  ft = "tex",
  standard = {
  },
  auto = {
      { trig = "bf", name = "mathbf", condition = in_mathzone(), priority = 10, body = "\\mathbf{$1}$0" },
      { trig = "ptl", name = "partial", condition = in_mathzone(), priority = 10, body = "\\partial " },
  }
}

return snippets

