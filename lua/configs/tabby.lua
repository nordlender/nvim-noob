
--   
local api = require("tabby.module.api")
local sep = require("user.icons").separator.triangle
local selected = require("user.icons").selected.diamond_slim

local make_tabs = function(line, tab, theme)
	local ret = {}
	local current_n = api.get_tab_number(api.get_current_tab())
	local n = tab.number()

	local lsep = (n > current_n and sep.l.up) or sep.l.lo
	local rsep = (n < current_n and sep.r.up) or sep.r.lo
	local hl = theme.tab

	if n == current_n then
		hl = theme.current_tab
		ret = {
			line.sep(lsep, hl, theme.fill),
			selected.y,
			tab.number(),
			tab.name(),
			tab.close_btn(''),
			line.sep(rsep, hl, theme.fill),
			hl = hl,
			margin = ' ',
		}
	else
		ret = {
			line.sep(lsep, hl, theme.fill),
			selected.n,
			tab.number(),
			line.sep(rsep, hl, theme.fill),
			hl = hl,
			margin = ' ',
		}

	end
	return ret
end

---@type TabbyConfig
return {
	require('tabby').setup({
		line = function(line)
			local theme = {
				fill = 'St_cwd_sep',		-- tabline background
				head = 'St_cwd_txt',		-- head element highlight
				current_tab = 'St_cwd_bg',	-- current tab label highlight
				tab = 'St_cwd_txt',         -- other tab label highlight
				win = 'St_cwd_txt',         -- window highlight
				tail = 'St_cwd_txt',        -- tail element highlight
			}
			return {
				{
					{ '  ', hl = theme.head },
					line.sep(sep.r.up, theme.head, theme.fill),
				},
				line.tabs().foreach(function(tab)
					return make_tabs(line, tab, theme)
				end),
				line.spacer(),
				line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
					return {
						line.sep(sep.l.up, theme.win, theme.fill),
						win.is_current() and '' or '',
						win.buf_name(),
						line.sep(sep.r.lo, theme.win, theme.fill),
						hl = theme.win,
						margin = ' ',
					}
				end),
				{
					line.sep(sep.l.up, theme.tail, theme.fill),
					{ '  ', hl = theme.tail },
				},
				hl = theme.fill,
			}
		end,
		option = {
			tab_name = {
        name_fallback = function(tabid)
          return "fallback name"
        end,
        override = function(tabid)
					local winid = api.get_tab_current_win(tabid)
					local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(winid))
					local ext = bufname:match("%.([%w]+)$") or "" -- get extension
					local fname = bufname:match("([^/]+)$") or bufname
					local no_ext = (ext ~= "" and fname:gsub("%.%w+$", "")) or fname
					local icon, color = require("user.icons").language(fname, ext)
					return no_ext .. " " .. icon
        end,
      },
		}, -- setup modules' option,
	})
}


	--  {
	--    'nanozuki/tabby.nvim', dependencies = { "nvim-tree/nvim-web-devicons" },
	--    config = function()
	--      require('tabby').setup({
	--		  preset = 'active_wins_at_end',
	--		  option = {
	--			theme = {
	-- 			fill = 'St_cwd_sep',       -- tabline background
	-- 			head = 'St_cwd_txt',           -- head element highlight
	-- 			current_tab = 'St_cwd_bg', -- current tab label highlight
	-- 			tab = 'St_cwd_txt',            -- other tab label highlight
	-- 			win = 'St_cwd_txt',            -- window highlight
	-- 			tail = 'St_cwd_txt',           -- tail element highlight
	-- 		},
	-- 		nerdfont = true,              -- whether use nerdfont
	-- 		tab_name = {
	-- 		name_fallback = function(tabid)
	-- 			return tabid
	-- 		end,
	-- 		},
	-- 		buf_name = {
	-- 		mode = 'unique', -- or 'relative', 'tail', 'shorten'
	-- 		},
	-- 	},
	-- })
