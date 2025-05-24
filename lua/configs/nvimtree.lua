-- copy of nvchad nvimtree config
dofile(vim.g.base46_cache .. "nvimtree")

-- Puts tex files first
-- local sorter = function(nodes)
--   table.sort(nodes, function(a, b)
--     local a_is_tex = a.extension == "tex"
--     local b_is_tex = b.extension == "tex"
--
--     if a_is_tex and not b_is_tex then
--       return true
--     elseif not a_is_tex and b_is_tex then
--       return false
--     else
--       return a.name:lower() < b.name:lower()
--     end
--   end)
-- end

return {
  filters = { dotfiles = false },
  disable_netrw = true,
  hijack_cursor = false,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    width = 30,
    preserve_window_proportions = true,
  },
  renderer = {
    root_folder_label = ":~:s?$?/..?",
    highlight_git = true,
    indent_markers = { enable = true },
    icons = {
      glyphs = {
        default = "󰈚",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
        },
        git = { unmerged = "" },
      },
    },
  },
  sort = {
    -- sorter = sorter, -- overrides next two options if function
    folders_first = true,
    files_first = false, -- overrides folders_first 
  }
}
