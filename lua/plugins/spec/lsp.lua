--- @type NvPluginSpec

return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format" },
        tex = { "tex_fmt"},
        -- css = { "prettier" },
        -- html = { "prettier" },
      },
      -- format_on_save = {
      --   -- These options will be passed to conform.format()
      --   timeout_ms = 500,
      --   lsp_fallback = true,
      -- },
    },

  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
  		return vim.tbl_deep_extend("force", require "nvchad.configs.treesitter", {
        -- User opts
        ensure_installed = {
          "vim", "vimdoc", "html", "css", "c", "lua", "luadoc", "printf"
        },
        ignore_install = {
          "latex",
        },
      })
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "mason-org/mason.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    -- BufRead is to make sure if you do nvim some_file then this is still going to be loaded
    event = { "VeryLazy", "BufRead" },
    config = function()
      -- load defaults i.e lua_lsp
      require("nvchad.configs.lspconfig").defaults()
      local lspconfig = require "lspconfig"
      local nvlsp = require "nvchad.configs.lspconfig"
      local servers = {
        texlab = {},
        html = {},
        cssls = {},
        stylua = {},
        lua_ls = {},
        clangd = {},
        ruff = {
          init_options = {
            settings = {
              -- Ruff language server settings here
            },
          }
        },
        pyright = {
          settings = {
            pyright = {
              -- Using Ruff's import organizer
              disableOrganizeImports = true,
            },
            python = {
              analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = { '*' },
              },
            },
          },
        },
      }
      lspconfig.ccls.setup {
        init_options = {
          cache = {
            directory = ".ccls-cache";
          };
        }
      }
      -- lsps with default config
      for server, config in pairs(servers) do
        lspconfig[server].setup {
          on_attach = nvlsp.on_attach,
          on_init = nvlsp.on_init,
          capabilities = nvlsp.capabilities,
          init_options = config.init_options,
          settings = config.settings,
        }
      end

      -- configuring single server, example: typescript
      -- lspconfig.ts_ls.setup {
      --   on_attach = nvlsp.on_attach,
      --   on_init = nvlsp.on_init,
      --   capabilities = nvlsp.capabilities,
      -- }

    end,
 -- Override to make sure load order is correct
  },
      -- lspconfig.ccls.setup {
      --   init_options = {
      --     cache = {
      --       directory = ".ccls-cache";
      --     };
      --   }
      -- }
}
