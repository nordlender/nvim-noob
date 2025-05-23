return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    'saghen/blink.cmp',
    version = '1.*',
    -- `main` is untested, please open a PR if you've confirmed it works as expected
    dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    opts = function ()
      return require('configs.blinkconfig').opts
    end,
    keymap = function()
      return require('configs.blinkconfig').keymap
    end,
  },
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
