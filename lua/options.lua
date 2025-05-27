-- Options
require "nvchad.options"
local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!


-- User commands
--
local usrcmd = vim.api.nvim_create_user_command
local utils = require('utils')

local fmt = string.format

usrcmd("ZathurarcEdit",
  function(cmdargs)
    local parsed_args = {}

    for _, arg in ipairs(cmdargs.fargs) do
      local key, value = string.match(arg, "([^=]+)=([^=]+)")

      key, value = utils.zedit.parse_input(key, value)
      if key ~= nil then
        parsed_args[key] = value
      else
        -- Printout handled in utils
        return
      end
    end

    local file = "zathurarc" -- required name
    local config_str, dir = utils.zedit.format_config(parsed_args)

    if not config_str and dir then
      print(fmt("%s: Error when formatting shell command", cmdargs.name))
      return
    end

    local obj = vim.system({
      fmt('echo \"%s\" > %s/%s', config_str, dir, file)
    }):wait(2)

    if obj.stderr then
      print(fmt("%s: write failed. Stderr: %s", cmdargs.name, obj.stderr))
      return
    end
    -- Success
    print(fmt(
      "%s: config written to %s/%s", cmdargs.name, dir, file
    ))
  end,
  { desc = "Edit Zathura config parameters" }
)

-- Autocmds
--
require "nvchad.autocmds"
local autocmd = vim.api.nvim_create_autocmd

-- Vimtex auto word count
--
autocmd({ "User" }, {
  pattern = "VimtexEventCompileStopped",
  group = vim.api.nvim_create_augroup("AutoWordcount", { clear = true }),
  callback = function (args)
    -- NOTE: I made a config edit option instead. I use a bash script to get
    -- my copy premade configs from a different directory to .config/zathura
    -- such that it works when opening pdfs from anywhere
    --
    -- ANTI EYE DAMAGE ALGORITHM
    -- very human design
    -- used to change config after dark
    -- local get_zathura_config_dir = function()
    --   local hour = tonumber(vim.fn.strftime("%H", vim.fn.localtime()))
    --   print(hour)
    --   if hour >= 6 and hour < 16 then
    --     return "~/.config/zathura/day"
    --   elseif hour >= 16 and hour < 22 then
    --     return "~/.config/zathura/evening"
    --   else
    --     return "~/.config/zathura/night"
    --   end
    -- end
    -- vim.g.zathura_config_dir = "~/.config/zathura"
    vim.cmd("VimtexCountWords")
  end,
})


-- (per) Window Statusline color changer
-- Sets unique (ish) color for each window for file block on stline
--
vim.g.wst_color_counts = {
  Win0 = 0, Win1 = 0, Win2 = 0, Win3 = 0, Win4 = 0, Win5 = 0, Win6 = 0, Win7 = 0
}

-- First window when entering vim, exempt from WinNew and WinEnter
autocmd({ "VimEnter" }, {
  group = vim.api.nvim_create_augroup("WindowSTLine", { clear = true }),
  callback = function(args)
    local id = utils.window_stline.check_win()
    if not id then return end

    local color = 'Win0'
    vim.api.nvim_win_set_var(id, 'wst_color', color)
    utils.window_stline.update_colormap(color, 1)
    utils.window_stline.set_highlight(color)

  end
})
-- Get new color when new window
autocmd({ "WinNew" }, {
  group = vim.api.nvim_create_augroup("WindowSTLine", {clear = false}),
  callback = function()
    -- uncomment to test
    -- utils.window_stline.test_get_color()
    local id = utils.window_stline.check_win()
    if not id then return end

    local color = utils.window_stline.get_color(vim.g.wst_color_counts)
    utils.window_stline.update_colormap(color, 1)
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
    local id = utils.window_stline.check_win()
    if not id then return end

    local color = utils.window_stline.get_wvar_safe(id, 'wst_color')
    if not color then return end
    -- Set
    -- print("set", id, color)
    utils.window_stline.set_highlight(color)
  end,
})
-- Decrement 
autocmd({ "WinClosed" }, {
  group = vim.api.nvim_create_augroup("WindowSTLine", { clear = false }),
  callback = function(args)
    local id = utils.window_stline.check_win()
    if not id then return end

    local color = utils.window_stline.get_wvar_safe(id, 'wst_color')
    if not color then return end

    utils.window_stline.update_colormap(color, -1)

    -- print("rem", id, color)
  end
})

-- End color changer
