
--   
local api = require("tabby.module.api")
local sep = require("user.icons").separator.triangle
local selected = require("user.icons").selected.diamond_slim

local not_float = function(win)
	return api.is_not_float_win(win.id)
end


local make_win_node = function(win, i, count, hl, lsep, rsep)
	local is_changed = win.buf().is_changed() and ' ' or ''
	local node = {
		is_changed, win.buf_name(), win.file_icon()
	}

	if count > 1 then
		node = {
			lsep,
			' ',
			is_changed,
			win.buf_name(),
			win.file_icon(),
			' ',
			rsep,
			hl = hl,
		}
	end
	return node
end

local make_win_nodes = function(wins, line, hl_tab)
	local after_current = false
	local hl = hl_tab
	local nodes = wins.foreach(function(win, i, count)
		local sep_line = ''
		local lsep = sep_line
		local rsep = ''

		if count > 1 then
			hl = vim.api.nvim_win_get_var(win.id, "wst_color")

			if win.is_current() then
				after_current = true
				lsep = line.sep(sep.l.up, hl, hl .. "txt")
				if i == 1 then
					lsep = line.sep(sep_line, hl .. "txt", hl)
				elseif i == count then
					rsep = line.sep(sep_line, hl .. "txt", hl)
				end

				hl = vim.api.nvim_get_hl(0, { name = hl })
				hl = { fg = hl.fg, bg = hl.bg, style = "bold" }
			else
				hl = hl .. "txt"
				if i == 1 or after_current then
					lsep = line.sep(sep.r.lo, hl_tab, hl_tab .. "txt")
				end
				if i == count then
					rsep = line.sep(sep.l.up, hl_tab, hl_tab .. "txt")
				end
				after_current = false
			end
		end

		return make_win_node(win, i, count, hl, lsep, rsep)
	end)
	return nodes
end

local make_tab = function(line, tab, theme)
	local ret = {}
	local current_n = api.get_tab_number(api.get_current_tab())
	local n = tab.number()

	local lsep = (n > current_n and sep.l.up) or sep.l.lo
	local rsep = (n < current_n and sep.r.up) or sep.r.lo
	local hl = theme.tab

	if n == current_n then
		hl = vim.api.nvim_win_get_var(tab.current_win().id, "wst_color")
		ret = {
			line.sep(lsep, hl, theme.fill),
			-- selected.y,
			tab.number(),
			make_win_nodes(tab.wins().filter(not_float), line, hl),
			line.sep(rsep, hl, theme.fill),
			hl = hl,
			margin = ' ',
		}
	else
		ret = {
			line.sep(lsep, hl, theme.fill),
			-- selected.n,
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
					return make_tab(line, tab, theme)
				end),
				line.spacer(),
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
      buf_name = {
      	name_fallback = function(bufid) return "fallback name" end,
      	override = function(bufid)
					local bufname = vim.api.nvim_buf_get_name(bufid)
					local ext = bufname:match("%.([%w]+)$") or "" -- get extension
					local fname = bufname:match("([^/]+)$") or bufname
					local no_ext = (ext ~= "" and fname:gsub("%.%w+$", "")) or fname
					if no_ext ~= '' then no_ext = no_ext .. ' ' end
					return no_ext
      	end
			}
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
