vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.scrolloff = 5
opt.wrap = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.termguicolors = true
opt.background = "light"
opt.signcolumn = "yes"
opt.updatetime = 250
opt.splitright = true
opt.splitbelow = true
opt.cursorline = true

vim.cmd.colorscheme("shine")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { silent = true, desc = "Write buffer" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>", { silent = true, desc = "Quit window" })
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "File explorer" })

if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --smart-case"
  opt.grepformat = "%f:%l:%c:%m"
end
