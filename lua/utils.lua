local M = {}

-- ZathurarcEdit
M.zedit = {
  parse_input= function(key, value)
    local e = nil -- e for error
    if not key or not value then
      e = "missing_value"
    else
      key = key:lower()

      if key == "recolor" or key == "keephue" then
        if value == "true" then
          value = true
        elseif value == "false" then
          value = false
        else
          e = "bool"
        end
      elseif key == "lightcolor" or key == "darkcolor" then
        if string.match(value, "^#%x%x%x%x%x%x$") == nil then
          e = "color"
        end
      elseif key == "dir" then
        -- use bash to check if it is a dir
        local obj = vim.system({
          string.format('[ -d "${%s}" ]', value), "&&", "echo", "-n", "1"
        }, { text = true }):wait(2)

        if not tonumber(obj.stdout) then
          e = "dir"
        end
      else
        e = "invalid_arg"
      end

    end
    if e then
      M.printf("Error! %s for key/value pair %s=%s", e, key, value)
      return nil, nil
    end
    return key, value
  end,

  -- Make config and dir
  format_config = function(args)
    -- NOTE: do echo "$HOME" in your cli to check if this exists
    local dir = "${HOME}/.config/zathura" -- default for me :)
    local lcolor = "#FFFFFF"
    local dcolor = "#000000"
    local keephue = "false"
    local recolor = "false"

    if args.lightcolor then
      lcolor = args.lightcolor
    end
    if args.darkcolor then
      dcolor = args.darkcolor
    end
    if args.keephue ~= nil then
      keephue = tostring(args.keephue)
    end
    if args.recolor ~= nil then
      recolor = tostring(args.recolor)
    end
    if args.dir then
      dir = args.dir
    else
      dir = vim.system({"echo", dir}):wait(2).stdout
    end

    local config_str = string.format(
      "recolor-lightcolor %s\nrecolor-darkcolor %s\nrecolor-keephue %s\nrecolor %s",
    lcolor, dcolor, keephue, recolor)
    return config_str, dir
  end,
}

M.window_stline = {
  -- Set highlight group, link to 'Winx' color
  set_highlight = function(color)
    local set_hl = vim.api.nvim_set_hl
    set_hl(0, "St_file_bg", { link = color, force = true})
    set_hl(0, "St_file_txt", { link = color .. "txt", force = true })
    set_hl(0, "St_file_sep", { link = color .. "sep", force = true })
  end,

  -- Increments or decrements counter for respective color 
  update_colormap = function(color, addend)
    local tbl = vim.api.nvim_get_var('wst_color_counts')
    local newval = tbl[color] + addend
    tbl[color] = newval
    vim.api.nvim_set_var('wst_color_counts', tbl)
  end,

  -- Finds next color with least use
  get_color = function(colormap)
    local min = -1
    local mincolor = 0
    for k, v in pairs(colormap) do
      if min == -1 or v < min then
        mincolor = k
        min = v
      end
    end
    return mincolor or nil
  end,

  test_get_color = function()
    local map = {
      Win0 = 1, Win1 = 0, Win2 = 0, Win3 = 0, Win4 = 0, Win5 = 0, Win6 = 0, Win7 = 0
    }
    local dmax = 0
    local color = 0
    local u, l = 0, 0

    for i=1, 1000 do
      color = get_color(map)
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
  end,

  -- Returns window-ID of current window if focusable and not float
  check_win = function()
    local id = vim.api.nvim_get_current_win()
    local config = vim.api.nvim_win_get_config(id)

    -- Ignore floats and non-focusable windows
    if config.relative ~= "" or not config.focusable then
      return 0
    end
    return id
  end,

  -- Passes all exceptions
  -- TODO: This can be fixed with User event pattern "TelescopeFindPre"
  get_wvar_safe = function(id, wvar)
    local success, color = pcall(function()
      local ret = vim.api.nvim_win_get_var(id, wvar)
      return ret
    end)

    if not success then
      -- print(string.format("In get_wvar_safe: Could not get %s for ID %d", wvar, id))
      return nil
    end
    return color
  end,
}

return M
