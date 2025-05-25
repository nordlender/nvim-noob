-- Options
require "nvchad.options"
local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!


-- Autocmds
require "nvchad.autocmds"
local autocmd = vim.api.nvim_create_autocmd


-- Statusline color changer
--
vim.g.stcolormap = {
  Win0 = 0, Win1 = 0, Win2 = 0, Win3 = 0, Win4 = 0, Win5 = 0, Win6 = 0, Win7 = 0
}

-- Set highlight group, link to 'Winx' color
local set_sep_highlight = function(color)
  vim.api.nvim_set_hl(0, "St_file_bg", { link = color, force = true})
  vim.api.nvim_set_hl(0, "St_file_txt", { link = color .. "txt", force = true })
  vim.api.nvim_set_hl(0, "St_file_sep", { link = color .. "sep", force = true })
end

-- 
local update_colormap = function(color, addend)
  local tbl = vim.api.nvim_get_var('stcolormap')
  local newval = tbl[color] + addend
  tbl[color] = newval
  vim.api.nvim_set_var('stcolormap', tbl)
end

-- Finds next color with least use
local get_color = function(colormap)
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

local test_get_color = function()
  local map = {
    Win0 = 1, Win1 = 0, Win2 = 0, Win3 = 0, Win4 = 0, Win5 = 0, Win6 = 0, Win7 = 0
  }
  local dmax = 0
  local color = 0
  for i=1, 1000 do
    color = get_color(map)
    map[color] = map[color] + 1

    local u = -50
    local l = math.huge
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
local check_win = function()
  local id = vim.api.nvim_get_current_win()
  local config = vim.api.nvim_win_get_config(id)

  -- Ignore floats and non-focusable windows
  if config.relative ~= "" or not config.focusable then
    return 0
  end
  return id
end

-- First window when entering vim, exempt from WinNew and WinEnter
autocmd({ "VimEnter" }, {
  group = vim.api.nvim_create_augroup("WindowSTLine", { clear = true }),
  callback = function(args)
    local id = check_win()
    if not id then return end

    local color = 'Win0'
    vim.api.nvim_win_set_var(id, 'stcolor', color)
    update_colormap(color, 1)
    set_sep_highlight(color)

  end
})

-- Get new color when new window
autocmd({ "WinNew" }, {
  group = vim.api.nvim_create_augroup("WindowSTLine", {clear = false}),
  callback = function()
    -- uncomment to test
    -- test_get_color()
    local id = check_win()
    if not id then return end

    local color = get_color(vim.g.stcolormap)
    update_colormap(color, 1)
    vim.api.nvim_win_set_var(id, 'stcolor', color)

    -- print("new", id, color)
    -- for k, v in pairs(vim.g.idmap) do print(k, v) end
    -- for k, v in pairs(vim.g.stcolormap) do print(k, v) end
  end
})

-- Set color when entering window
autocmd({ "WinEnter" }, {
  group = vim.api.nvim_create_augroup("WindowSTLine", { clear = false }),
  callback = function(args)
    local id = check_win()
    if not id then return end

    local color = vim.api.nvim_win_get_var(id, 'stcolor')

    -- Set
    -- print("set", id, color)
    set_sep_highlight(color)
  end,
})

-- Decrement 
autocmd({ "WinClosed" }, {
  group = vim.api.nvim_create_augroup("WindowSTLine", { clear = false }),
  callback = function(args)
    local id = check_win()
    if not id then return end

    local color = vim.api.nvim_win_get_var(id, 'stcolor')
    update_colormap(color, -1)

    -- print("rem", id, color)
  end
})

-- End color changer
