-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- User LSP options
local opts = {
  ruff = {
    init_options = {
      settings = {
        -- Ruff language server settings here
      },
    },
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
  texlab = {},
  html = {},
  cssls = {}

}

lspconfig.ccls.setup {
  init_options = {
    cache = {
      directory = ".ccls-cache";
    };
  }
}

-- lsps with default config
for server, config in pairs(opts) do
  lspconfig[server].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = vim.tbl_deep_extend(
      'force', nvlsp.capabilities, require('blink.cmp').get_lsp_capabilities({}, false)
    ),
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
