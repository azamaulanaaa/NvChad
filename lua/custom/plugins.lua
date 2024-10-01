local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
    },
  },
  { -- implement lsp
    "neovim/nvim-lspconfig",
    config = function(LazyPlugin, opts)
      local lspconfig = require "lspconfig"

      local config = require "plugins.configs.lspconfig"
      local default_config = {
        on_attach = config.on_attach,
        capabilites = config.capabilities,
      }

      local servers = {
        html = {},
        pyright = {},
        ts_ls = {},
        sqls = {},
        graphql = {},
        rust_analyzer = {},
        clangd = {},
        jsonls = {},
      }

      for server, config in pairs(servers) do
        lspconfig[server].setup(vim.tbl_deep_extend("force", default_config, config))
      end
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = { -- enable git on file tree
        enable = true,
        ignore = false,
        timeout = 5000, -- increase git timout especialy in nodejs project
      },

      renderer = {
        indent_markers = {
          enable = true, -- draw indent line marker
        },

        icons = {
          show = {
            git = true, -- draw git icons
          },
        },
      },
    },
  },
  { -- cursor assistant
    "ggandor/leap.nvim",
    lazy = false,
    config = function(LazyPlugin, opts)
      require("leap").add_default_mappings()
    end,
  },
  { -- enable formatter
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { { "autopep8", "isort", "black" } },
        javascript = { { "prettier", "prettierd" } },
        typescript = { { "prettier", "prettierd" } },
        javascriptreact = { { "prettier", "prettierd" } },
        typescriptreact = { { "prettier", "prettierd" } },
        html = { { "prettier", "prettierd" } },
        css = { { "prettier", "prettierd" } },
        json = { { "prettier", "prettierd" } },
        rust = { "rustfmt" },
        sql = { "sqlfmt" },
        graphql = { { "prettier", "prettierd" } },
        ["_"] = { "trim_whitespace" },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      local lint = require "lint"

      lint.linters_by_ft = {
        javascript = { "oxlint" },
        typescript = { "oxlint" },
        javascriptreact = { "oxlint" },
        typescriptreact = { "oxlint" },
        python = { "ruff" },
      }
    end,
  },
  { -- code outline
    "stevearc/aerial.nvim",
    lazy = false,
    opts = {
      filter_kind = false,
      layout = {
        width = 30,
      },
    },
  },
}

return plugins
