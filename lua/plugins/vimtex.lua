return {
  {"lervag/vimtex",
  ft = "tex", -- Lazy load on filetype tex 
  -- tag = "v2.15", -- uncomment to pin to a specific release

  init = function()
    -- used to change config after dark
    local is_day = function()
      local hour = tonumber(vim.fn.strftime("%H", vim.fn.localtime()))
      if hour >= 6 and hour < 18 then
        return true
      else
        return false
      end
    end

    -- set to dir containing zathurarc
    local zathura_config_dir
    if is_day() then
      zathura_config_dir = "~/.config/zathura/day"
    else
      zathura_config_dir = "~/.config/zathura/night"
    end

    -- VimTeX configuration goes here, e.g.
    -- vim.g.vimtex_view_general_viewer = 'evince'
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_view_zathura_options = "-c " .. zathura_config_dir
    vim.opt.conceallevel = 2
    vim.g.tex_conceal = "abdmg"
  end
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

      local ls = require("luasnip")
      
      -- set a higher priority (defaults to 0 for most snippets)
      local snippets = require "snippets.tex"
      local parsed_snippets = {auto={}, standard={}}

      -- parse snippets
      for _, snip in ipairs(snippets.auto) do
        table.insert(parsed_snippets.auto, ls.parser.parse_snippet(
          { trig = snip.trig, name = snip.name, condition = snip.condition, priority = snip.priority },
          snip.body
        ))
      end
      for _, snip in ipairs(snippets.standard) do
        table.insert(parsed_snippets.standard, ls.parser.parse_snippet(
          { trig = snip.trig, name = snip.name, condition = snip.condition, priority = snip.priority },
          snip.body
        ))
      end

      ls.add_snippets("tex", parsed_snippets.auto, { type = "autosnippets" })
      ls.add_snippets("tex", parsed_snippets.standard)
    end,
  },
}
