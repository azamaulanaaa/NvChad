local plugins = {
  { -- implement lsp
    "neovim/nvim-lspconfig",
    config = function(LazyPlugin, opts)
      local lspconfig = require "lspconfig"
      local config = require "plugins.configs.lspconfig"
      local servers = {
        "rust_analyzer",
        "html",
        "pyright",
        "tsserver",
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup {
          on_attach = config.on_attach,
          capabilities = config.capabilities,
        }
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
    opts = {
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
    },
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
}

return plugins
