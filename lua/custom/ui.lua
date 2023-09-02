local M = {}

M.theme = "vscode_dark" -- colorscheme
M.statusline = { -- statusline style
  separator_style = "block",
}
M.tabufline = {
  overriden_modules = function(modules)
    table.remove(modules, 4) -- removing close button on top right
  end,
}

return M
