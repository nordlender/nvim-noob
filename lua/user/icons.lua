local M = {}

M.language = function(filename, extension)
	local icon, color = require("nvim-web-devicons").get_icon(
		filename, extension, { default = true }
	)
	return icon, color
end

M.map = {
	num_to_word = {
		[0] = "zero",
		[1] = "one",
		[2] = "two",
		[3] = "three",
		[4] = "four",
		[5] = "five",
		[6] = "six",
		[7] = "seven",
		[8] = "eight",
		[9] = "nine",
		[10] = "ten"
	},
}

M.file = {
  default = "󰈚",
  symlink = "",
  modified = "●",
  hidden = "󰜌",
}

M.folder = {
  arrow_closed = "",
  arrow_open = "",
  default = "󰉋",
  open = "󰝰",
  empty = "󰉖",
  empty_open = "󰷏",
  symlink = "",
  symlink_open = "",
}

M.git = {
  unstaged = "✗",
  staged = "✓",
  unmerged = "",
  renamed = "➜",
  untracked = "★",
  deleted = "",
  ignored = "◌",
}

M.indent_markers = {
  corner = "└",
  edge = "│",
  item = "│",
  bottom = "─",
  none = " ",
}
--    󰲠 󰲢 󰲤 󰲦 󰲨 󰲪 󰲬 󰲮 󰲰 󰿬 󰲲 󰎤
M.diamond = {
	slim = {
		y = "󰣏",
		n = "󱀝",
	},
	wide = {
		y = "",
		n = "",
	},
}

M.numeric = {
	standard = {
    one   = "󰬺",
    two   = "󰬻",
    three = "󰬼",
    four  = "󰬽",
    five  = "󰬾",
    six   = "󰬿",
    seven = "󰭀",
    eight = "󰭁",
    nine  = "󰭂",
    ten   = "󰿩",
    nine_plus = "󰿮",
    plus_one = "󱗋",
    minus_one = "󱁒"
	},
	circle = {
		filled = {
			one   = "󰲠",
			two   = "󰲢",
			three = "󰲤",
			four  = "󰲦",
			five  = "󰲨",
			six   = "󰲪",
			seven = "󰲬",
			eight = "󰲮",
			nine  = "󰲰",
			ten   = "󰿬",
			nine_plus = "󰲲",
		},
		outline = {
			one   = "󰲡",
			two   = "󰲣",
			three = "󰲥",
			four  = "󰲧",
			five  = "󰲩",
			six   = "󰲫",
			seven = "󰲭",
			eight = "󰲯",
			nine  = "󰲱",
			ten   = "󰿭",
			nine_plus = "󰲳",
		}
	},
	box = {
		filled = {
			zero  = "󰎡",
			one   = "󰎤",
			two   = "󰎧",
			three = "󰎪",
			four  = "󰎭",
			five  = "󰎱",
			six   = "󰎳",
			seven = "󰎶",
			eight = "󰎹",
			nine  = "󰎼",
			ten   = "󰽽",
			nine_plus = "󰎿",
		},
		outline = {
			zero  = "󰎣",
			one   = "󰎦",
			two   = "󰎩",
			three = "󰎬",
			four  = "󰎮",
			five  = "󰎰",
			six   = "󰎵",
			seven = "󰎸",
			eight = "󰎻",
			nine  = "󰎾",
			ten   = "󰽾",
			nine_plus = "󰏁",
		}
	}
}

--      
M.separator = {
	arrow = {
		l = "",
		r = "",
	},
	inverted_arrow = {
		l = "",
		r = "",
	},
	round = {
		l = "",
		r = "",
	},
	-- This will always be confusing...
	triangle = {
		l = {
			up = "",
			lo = "",
		},
		r = {
			up = "",
			lo = "",
		},
	},
}

M.tree = {
  glyphs = {
    folder = M.folder,
    git = M.git,
    default = M.file.default,
    symlink = M.file.symlink,
    modified = M.file.modified,
    hidden = M.file.hidden,
  },
  indent_markers = M.indent_markers,
}

return M
