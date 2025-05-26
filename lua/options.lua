-- Options
require "nvchad.options"
local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!


-- Autocmds
require "nvchad.autocmds"
local autocmd = vim.api.nvim_create_autocmd

-- Vimtex auto word count
--
autocmd({ "User" }, {
  pattern = "VimtexEventCompileStopped",
  group = vim.api.nvim_create_augroup("AutoWordcount", { clear = true }),
  callback = function (args)
    -- ANTI EYE DAMAGE ALGORITHM
    -- very human design
    -- used to change config after dark, i should implement this in cmdline
    local get_zathura_config_dir = function()
      local hour = tonumber(vim.fn.strftime("%H", vim.fn.localtime()))
      print(hour)
      if hour >= 6 and hour < 16 then
        return "~/.config/zathura/day"
      elseif hour >= 16 and hour < 22 then
        return "~/.config/zathura/evening"
      else
        return "~/.config/zathura/night"
      end
    end
    vim.g.zathura_config = get_zathura_config_dir()
    vim.cmd("VimtexCountWords")
  end,
})


-- (per) Window Statusline color changer
-- Sets unique (ish) color for each window for file block on stline
--
vim.g.wst_color_counts = {
  Win0 = 0, Win1 = 0, Win2 = 0, Win3 = 0, Win4 = 0, Win5 = 0, Win6 = 0, Win7 = 0
}

-- Set highlight group, link to 'Winx' color
local wst_set_highlight = function(color)
  local set_hl = vim.api.nvim_set_hl
  set_hl(0, "St_file_bg", { link = color, force = true})
  set_hl(0, "St_file_txt", { link = color .. "txt", force = true })
  set_hl(0, "St_file_sep", { link = color .. "sep", force = true })
end

-- Increments or decrements counter for respective color 
local wst_update_colormap = function(color, addend)
  local tbl = vim.api.nvim_get_var('wst_color_counts')
  local newval = tbl[color] + addend
  tbl[color] = newval
  vim.api.nvim_set_var('wst_color_counts', tbl)
end

-- Finds next color with least use
local wst_get_color = function(colormap)
  local min = -1
  local mincolor = 0
  for k, v in pairs(colormap) do
    if min == -1 or v < min then
      mincolor = k
      min = v
    end
  end
  return mincolor or nil
end

local wst_test_get_color = function()
  local map = {
    Win0 = 1, Win1 = 0, Win2 = 0, Win3 = 0, Win4 = 0, Win5 = 0, Win6 = 0, Win7 = 0
  }
  local dmax = 0
  local color = 0
  local u, l = 0, 0

  for i=1, 1000 do
    color = wst_get_color(map)
    map[color] = map[color] + 1

    u = -50
    l = math.huge
    for _, v in pairs(map) do
      l = math.min(l, v)
      u = math.max(l, v)
    end
    dmax = math.max(dmax, u-l)
  end

  assert(dmax < 2, "WindowSTLine test function failed")
  for k, v in pairs(map) do
    print(k, v)
  end
end

-- Returns window-ID of current window if focusable and not float
local wst_check_win = function()
  local id = vim.api.nvim_get_current_win()
  local config = vim.api.nvim_win_get_config(id)

  -- Ignore floats and non-focusable windows
  if config.relative ~= "" or not config.focusable then
    return 0
  end
  return id
end

-- Passes all exceptions
-- TODO: This can be fixed with User event pattern "TelescopeFindPre"
local wst_get_wvar_safe = function(id, wvar)
  local success, color = pcall(function()
    local ret = vim.api.nvim_win_get_var(id, wvar)
    return ret
  end)

  if not success then
    -- print(string.format("In get_wvar_safe: Could not get %s for ID %d", wvar, id))
    return nil
  end
  return color
end

-- First window when entering vim, exempt from WinNew and WinEnter
autocmd({ "VimEnter" }, {
  group = vim.api.nvim_create_augroup("WindowSTLine", { clear = true }),
  callback = function(args)
    local id = wst_check_win()
    if not id then return end

    local color = 'Win0'
    vim.api.nvim_win_set_var(id, 'wst_color', color)
    wst_update_colormap(color, 1)
    wst_set_highlight(color)

  end
})

-- Get new color when new window
autocmd({ "WinNew" }, {
  group = vim.api.nvim_create_augroup("WindowSTLine", {clear = false}),
  callback = function()
    -- uncomment to test
    -- wst_test_get_color()
    local id = wst_check_win()
    if not id then return end

    local color = wst_get_color(vim.g.wst_color_counts)
    wst_update_colormap(color, 1)
    vim.api.nvim_win_set_var(id, 'wst_color', color)

    -- print("new", id, color)
    -- for k, v in pairs(vim.g.idmap) do print(k, v) end
    -- for k, v in pairs(vim.g.wst_color_counts) do print(k, v) end
  end
})

-- Set color when entering window
autocmd({ "WinEnter" }, {
  group = vim.api.nvim_create_augroup("WindowSTLine", { clear = false }),
  callback = function(args)
    local id = wst_check_win()
    if not id then return end

    local color = wst_get_wvar_safe(id, 'wst_color')
    if not color then return end
    -- Set
    -- print("set", id, color)
    wst_set_highlight(color)
  end,
})

-- Decrement 
autocmd({ "WinClosed" }, {
  group = vim.api.nvim_create_augroup("WindowSTLine", { clear = false }),
  callback = function(args)
    local id = wst_check_win()
    if not id then return end

    local color = wst_get_wvar_safe(id, 'wst_color')
    if not color then return end

    wst_update_colormap(color, -1)

    -- print("rem", id, color)
  end
})

-- End color changer
