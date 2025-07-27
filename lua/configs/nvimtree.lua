-- copy of nvchad nvimtree config
dofile(vim.g.base46_cache .. "nvimtree")

local user_on_attach = function()
	
	local api = require("nvim-tree.api")
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	-- See nvim-tree-mappings-default
	vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
end

return {
  -- on_attach = user_on_attach,
  filters = { dotfiles = false },
  disable_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    cursorline = true,
    signcolumn = "auto",
    width = {
      min = 20,
      max = -1,
      padding = 0,
    },
    float = {
      enable = true,
      quit_on_focus_loss = false,
      open_win_config = {
        relative = "win",
        anchor = "SE",
        row = vim.api.nvim_win_get_height(0) - 1,
        col = vim.api.nvim_win_get_width(0) - 1,
        border = "single",
      },
    },
  },
  renderer = {
    root_folder_label = ":~:s?$?/..?",
    highlight_git = true,
    indent_markers = {
      enable = true,
      icons = require("user.icons").tree.indent_markers,
    },
    indent_width = 1,
    icons = {
    	glyphs = require("user.icons").tree.glyphs,
    	show = { modified = true, }
    },
  },
  modified = {
	enable = true,
  },
  sort = {
    -- sorter = sorter, -- overrides next two options if function
    folders_first = true,
    files_first = false, -- overrides folders_first 
  }
}
