local M = {}

M.disabled = {
  n = {
    ["<C-n>"] = "", -- replace nvimtree toggle to ctrl+o
  },
}

M.nvimtree = {
  n = {
    ["<C-o>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
  },
}

M.aerial = {
  n = {
    ["<C-a>"] = { "<cmd> AerialToggle <CR>", "Toggle aerial" },
  },
}

return M
