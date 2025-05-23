return {
  opts = {
    snippets = { preset = "luasnip" },
    -- ensure you have the `snippets` source (enabled by default)
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    completion = {
      -- 'prefix' will fuzzy match on the text before the cursor
      -- 'full' will fuzzy match on the text before _and_ after the cursor
      -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
      keyword = {
        range = "prefix",
      },

      -- Disable auto brackets
      -- NOTE: some LSPs may add auto brackets themselves anyway
      accept = { 
        auto_brackets = { enabled = false },
        create_undo_point = true,
      },

      -- Don't select by default, auto insert on selection
      list = { selection = { preselect = false, auto_insert = true } },
      ghost_text = { enabled = true },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = "single" },
      },
    },
    fuzzy = {
      implementation = 'prefer_rust_with_warning',
      use_frecency = true,
      sorts = {
        'exact',
        -- defaults
        'score',
        'sort_text',
      },
    }
  },
  keymap = {
    preset = "default",
    ["<CR>"] = { "accept", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    ["<C-n>"] = { "select_next", "snippet_forward", "fallback" },
    ["<C-p>"] = { "select_prev", "snippet_backward", "fallback" },
  },
}
