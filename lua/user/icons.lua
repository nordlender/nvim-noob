local M = {}

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
