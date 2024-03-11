local g = vim.g
local o = vim.o
local go = vim.go
local wo = vim.wo

g.mapleader = "\\" -- reset leader to \

o.wrap = false
o.scrolloff = 4 -- add 4 lines space while scroll vertically
o.sidescrolloff = 12 -- add 12 chars space while scroll horizontally

-- try new powershell if exist
o.shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell"
o.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
o.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
o.shellquote = ""
o.shellxquote = ""

go.guifont = "FiraCode Nerd Font:h12"

wo.relativenumber = true
