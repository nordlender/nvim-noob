-- Options
require "nvchad.options"
local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!


-- Autocmds
require "nvchad.autocmds"
local autocmd = vim.api.nvim_create_autocmd

-- autocmd({ "WinEnter", "WinLeave" }, {
--   group = vim.api.nvim_create_augroup("ActiveWindowBorder", { clear = true }),
--   callback = function(args)
--     local border = (args.event == "WinEnter" and 'solid' or 'none')
--     local wincfg = vim.api.nvim_win_get_config(0)
--     if (wincfg.relative or 0) then return end
--
--     wincfg.border = border
--     vim.api.nvim_win_set_config(0, wincfg)
--   end,
-- })

-- autocmd({ "WinEnter", "WinLeave" }, {
--   group = vim.api.nvim_create_augroup("ActiveWindowBorder", { clear = true }),
--   callback = function(args)
--     local border = function(event)
--       local ret = {'none'}
--       if event == "WinEnter" then
--         ret = { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }
--       end
--       return ret 
--     end
--     local wincfg = vim.api.nvim_win_get_config(0)
--     if (wincfg.relative or 0) then return end
--
--     wincfg.border = border(args.event)
--     vim.api.nvim_win_set_config(0, wincfg)
--   end,
-- })
--
--  "Win0", "Win1", "Win2", "Win3", "Win4", "Win5", "Win6", "Win7"

vim.g.stcolormap = {
  Win0 = 1, Win1 = 0, Win2 = 0, Win3 = 0, Win4 = 0, Win5 = 0, Win6 = 0, Win7 = 0
}

autocmd({ "VimEnter" }, {
  group = vim.api.nvim_create_augroup("WindowSTLine", { clear = true }),
  command = "let w:stcolor='Win0'"
})

local mapcolor = function(id, color)
  vim.api.nvim_win_set_var(id, 'stcolor', color)
  local tbl = vim.api.nvim_get_var('stcolormap')

  -- Lua what the fuck why
  local newval = tbl[color] + 1
  tbl[color] = newval
  vim.api.nvim_set_var('stcolormap', tbl)
end

local set_sep_highlight = function(color)
  vim.api.nvim_set_hl(0, "St_file_bg", { link = color, force = true})
  vim.api.nvim_set_hl(0, "St_file_txt", { link = color .. "sep", force = true })
  vim.api.nvim_set_hl(0, "St_file_sep", { link = color .. "sep", force = true })
end

autocmd({ "WinEnter", "WinClosed" }, {
  group = vim.api.nvim_create_augroup("WindowSTLine", { clear = false }),
  callback = function(args)
    local winid = vim.api.nvim_get_current_win()

    -- Ignore floating
    local isrelative = vim.api.nvim_win_get_config(winid).relative
    if isrelative ~= "" then return end

    local wincolor = vim.w.stcolor
    local new = 0
    if not wincolor then
      local m = 1
      new = 1
      for color, n in pairs(vim.g.stcolormap) do
        m = math.max(m, n)
        if n < m then
          mapcolor(winid, color)
          wincolor = color
          break
        end
        mapcolor(winid, "Win7")
      end
    end
    for k, v in pairs(vim.g.stcolormap) do print(k, v) end
    -- Set or remove
    if args.event == "WinClosed" then
      vim.w.stcolor = nil
    else
      print(new, "set", winid, wincolor)
      set_sep_highlight(wincolor)
    end
  end,
})
