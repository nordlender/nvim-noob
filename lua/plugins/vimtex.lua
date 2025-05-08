return {
  {"lervag/vimtex",
  ft = "tex", -- Lazy load on filetype tex 
  -- tag = "v2.15", -- uncomment to pin to a specific release

  init = function()
    -- set nightmode in zathura
    local is_day = function()
      local hour = tonumber(vim.fn.strftime("%H", vim.fn.localtime()))
      if hour >= 6 and hour < 18 then
        return true
      else
        return false
      end
    end
        local zathura_config_path
    if is_day() then
      zathura_config_path = "~/.config/zathura/day"
    else
      zathura_config_path = "~/.config/zathura/night"
    end

    -- VimTeX configuration goes here, e.g.
    -- vim.g.vimtex_view_general_viewer = 'evince'
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_view_zathura_options = "-c " .. zathura_config_path
    vim.opt.conceallevel = 2
    vim.g.tex_conceal = "abdmg"
  end
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
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
      local utils = require("luasnip-latex-snippets.util.utils")
      -- local is_math = utils.is_math -- pass true if using Treesitter
      
      -- to prevent vimtex#syntax#in_mathzone not found
      local safe_is_math = function()
        if vim.fn.exists("vimtex#syntax#in_mathzone") then
          return utils.is_math
        else
          return 0
        end
      end

      -- set a higher priority (defaults to 0 for most snippets)
      local snippets = {
        { trig = "bf", name = "mathbf", condition = safe_is_math()(), priority = 10, body = "\\mathbf{$1}$0" },
        { trig = "ptl", name = "partial", condition = safe_is_math()(), priority = 10, body = "\\partial " },
      }

      local parsed_snippets = {}

      for _, snip in ipairs(snippets) do
        table.insert(parsed_snippets, ls.parser.parse_snippet(
          { trig = snip.trig, name = snip.name, condition = snip.condition, priority = snip.priority },
          snip.body
        ))
      end

      ls.add_snippets("tex", parsed_snippets, { type = "autosnippets" })
          end,
        },
}
