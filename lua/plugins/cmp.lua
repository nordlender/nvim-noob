---@type NvPluginSpec
return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    --opts
  },
  dependencies = {
    { "hrsh7th/cmp-cmdline" },
    { "brenoprata10/nvim-highlight-colors" },
    --{'quangnguyen30192/cmp-nvim-ultisnips'},
  },
  config = function(_, opts)
    local cmp = require "cmp"

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "cmdline" },
        { name = "path" },
        {
          name = "lazydev",
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        },
      },
    })

    local colors = require "nvim-highlight-colors.color.utils"
    local utils = require "nvim-highlight-colors.utils"

    ---@class cmp.FormattingConfig
    --- This makes chadrc.ui.cmp take no effect
    opts.formatting = {
      fields = { "abbr", "kind", "menu" },

      format = function(entry, item)
        local icons = require "nvchad.icons.lspkind"
        icons.Color = "󱓻"

        local icon = " " .. icons[item.kind] .. " "
        item.kind = string.format("%s%s ", icon, item.kind)

        local entryItem = entry:get_completion_item()
        if entryItem == nil then
          return item
        end

        local entryDoc = entryItem.documentation
        if entryDoc == nil or type(entryDoc) ~= "string" then
          return item
        end

        local color_hex = colors.get_color_value(entryDoc)
        if color_hex == nil then
          return item
        end

        local highlight_group = utils.create_highlight_name("fg-" .. color_hex)
        vim.api.nvim_set_hl(0, highlight_group, { fg = color_hex, default = true })
        item.kind_hl_group = highlight_group

        return item
      end,
    }

    opts = vim.tbl_deep_extend("force", opts, {
      mapping = {
        ["<Tab>"] = function(fallback)
          fallback()
        end,
        ["<S-Tab>"] = function(fallback)
          fallback()
        end,
      },
      window = {
        completion = {
          border = "rounded",
        },
        documentation = {
          border = "rounded",
        },
      },
      -- Ultisnips
      --snippet = {
      --  expand = function(args)
      --  vim.fn["UltiSnips#Anon"](args.body)
      --  end,
      --},
    })
    cmp.setup(opts)
  end,
}
