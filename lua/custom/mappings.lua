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

return M
