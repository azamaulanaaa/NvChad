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
    "mhartington/formatter.nvim",
    lazy = false,
    opts = function(LazyPlugin, opts)
      return {
        filetype = {
          lua = {
            require("formatter.filetypes.lua").stylua,
          },
          rust = {
            require("formatter.filetypes.rust").rustfmt,
          },
          javascript = {
            require("formatter.filetypes.javascript").prettierd,
          },
          javascriptreact = {
            require("formatter.filetypes.javascriptreact").prettierd,
          },
          json = {
            require("formatter.filetypes.json").prettierd,
          },
          typescript = {
            require("formatter.filetypes.typescript").prettierd,
          },
          typescriptreact = {
            require("formatter.filetypes.typescriptreact").prettierd,
          },
          ["*"] = {
            require("formatter.filetypes.any").remove_trailling_whitespace,
          },
        },
      }
    end,
    config = function(LazyPlugin, opts)
      require("formatter").setup(opts)

      local FormatAutogroup = vim.api.nvim_create_augroup("FormatAutogroup", {
        clear = true,
      })

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        group = FormatAutogroup,
        pattern = { "*" },
        callback = function(ev)
          vim.api.nvim_command "FormatWrite"
        end,
      })
    end,
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
