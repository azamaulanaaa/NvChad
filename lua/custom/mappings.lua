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

M.todo = {
  n = {
    ["<leader>tt"] = { "<cmd> TodoQuickFix keyword=TODO,FIX <CR>", "Toggle todo telescope" }
  }
}

return M
