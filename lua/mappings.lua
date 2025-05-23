require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

--map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
--map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
--map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
--map("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
--map("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })

-- Toggles
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle relative number" })

-- term
local term = require "nvchad.term"

map("t", "<C-x>", "<C-\\><C-N>", { desc = "Term escape terminal mode" })
map("t", "<A-x>", "<C-\\><C-n>:q<CR>", { desc = "Term close" })

map({ "n", "t" }, "<A-v>", function()
  term.toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "Term toggle vertical split" })

map({ "n", "t" }, "<A-h>", function()
  term.toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "Term toggle horizontal split" })

map({ "n", "t" }, "<A-t>", function()
  term.toggle { pos = "float", id = "ftoggleTerm" }
end, { desc = "Term toggle float" })

map({ "n", "t" }, "<C-A-l>", function()
  term.toggle {
    pos = "sp",
    id = "htoggleTermLoc",
    cmd = "cd " .. vim.fn.expand "%:p:h",
  }
end, { desc = "Term toggle horizontal split in buffer location" })

map({ "n", "t" }, "<A-r>", function()
  vim.cmd("w")
  require("nvchad.term").runner {
    id = "py_runner",
    pos = "float",
    cmd = "python " .. vim.fn.expand("%"),
    clear_cmd = false,
  }
end, { desc = "Run current Python file in vertical split terminal" })

-- open config
map("n", "<leader>nv", function()
  local api = require("nvim-tree.api")
  vim.cmd("cd ~/.config/nvim")           -- change working directory
  api.tree.open()
  api.tree.change_root("~/.config/nvim") -- change tree root
end, { desc = "Open nvim config folder" })

-- Luasnip
local ls = require("luasnip")
map({ "i", "s" }, "<Tab>", function() ls.jump(1) end, { silent = true })
map({ "i", "s" }, "<S-Tab>", function() ls.jump(-1) end, { silent = true })

map({ 'i', 's' }, '<Tab>', function()
  if vim.snippet.active { direction = 1 } then
    return "<Cmd>lua vim.snippet.jump(1)<CR>"
  else
    return "<Tab>"
  end
end, { desc = '...', expr = true, silent = true })

-- Disable Arrows
map('n', '<Left>', ':echo "No left for you!"<CR>', { noremap = true, silent = true })
map('v', '<Left>', ':<C-u>echo "No left for you!"<CR>', { noremap = true, silent = true })
map('i', '<Left>', '<C-o>:echo "No left for you!"<CR>', { noremap = true, silent = true })

map('n', '<Right>', ':echo "No right for you!"<CR>', { noremap = true, silent = true })
map('v', '<Right>', ':<C-u>echo "No right for you!"<CR>', { noremap = true, silent = true })
map('i', '<Right>', '<C-o>:echo "No right for you!"<CR>', { noremap = true, silent = true })

map('n', '<Up>', ':echo "No up for you!"<CR>', { noremap = true, silent = true })
map('v', '<Up>', ':<C-u>echo "No up for you!"<CR>', { noremap = true, silent = true })
map('i', '<Up>', '<C-o>:echo "No up for you!"<CR>', { noremap = true, silent = true })

map('n', '<Down>', ':echo "No down for you!"<CR>', { noremap = true, silent = true })
map('v', '<Down>', ':<C-u>echo "No down for you!"<CR>', { noremap = true, silent = true })
map('i', '<Down>', '<C-o>:echo "No down for you!"<CR>', { noremap = true, silent = true })
