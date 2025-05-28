return {
  {
    "lervag/vimtex",
    ft = "tex", -- Lazy load on filetype tex 
    -- tag = "v2.15", -- uncomment to pin to a specific release

    init = function()
      -- VimTeX configuration goes here, e.g.
      -- vim.g.vimtex_view_general_viewer = 'evince'
      vim.g.vimtex_view_method = "zathura_simple" -- Use zathura_simple for wayland

      -- Remove these lines to use regular config. See options.lua
      vim.g.zathura_config_dir = "~/.config/zathura"
      vim.g.vimtex_view_zathura_options = "-c " .. vim.g.zathura_config_dir

      vim.opt.conceallevel = 2
      vim.g.tex_conceal = "abdmg"
      vim.o.linebreak = true

      -- Mappings
      local map = vim.keymap.set
      -- change j and k when in latex (works for wrapped lines)
      map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
      map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

    end,
  },
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    -- vimtex isn't required if using treesitter
    ft = "tex",
    requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },

    config = function()
      require'luasnip-latex-snippets'.setup({
        use_treesitter = false,
      })
      -- or setup({ use_treesitter = true })
      require("luasnip").config.setup {
        enable_autosnippets = true,
      }

      -- Snippets
      local ls = require("luasnip")
      local snippets = require "snippets.tex"

      -- parse snippets
      for type, sniplist in pairs(snippets) do
        local parsed_snippets = {}
        for snip in vim.iter(sniplist) do
          table.insert(parsed_snippets, ls.parser.parse_snippet(
            { trig = snip.trig, name = snip.name, condition = snip.condition, priority = snip.priority },
            snip.body
          ))
        end
        -- Set type
        ls.add_snippets("tex", parsed_snippets, { type = type })
      end
    end,
  },
}
