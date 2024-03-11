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
      local default_config = require "plugins.configs.lspconfig"
      local servers = {
        rust_analyzer = {},
        html = {},
        pyright = {},
        tsserver = {},
        sqls = {},
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
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        javascriptreact = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        html = { { "prettierd", "prettier" } },
        css = { { "prettierd", "prettier" } },
        json = { { "prettierd", "prettier" } },
        rust = { "rustfmt" },
        sql = { "sqlfmt" },
        ["_"] = { "trim_whitespace" },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
  },
  { -- neovim available for firefox/chrome
    "glacambre/firenvim",
    lazy = not vim.g.started_by_firenvim,
    build = function()
      vim.fn["firenvim#install"](0)
    end,
    config = function()
      vim.g.firenvim_config = {
        localSettings = {
          [".*"] = {
            takeover = "never",
          },
        },
      }
    end,
  },
}

return plugins
