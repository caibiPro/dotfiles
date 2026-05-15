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
opt.signcolumn = "yes"
opt.updatetime = 250
opt.splitright = true
opt.splitbelow = true
opt.cursorline = true

local function system_appearance()
  -- macOS only: "Dark" in dark mode, error/empty in light mode
  local out = vim.trim(vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null"))
  return out == "Dark" and "dark" or "light"
end

local function apply_appearance()
  local mode = system_appearance()
  opt.background = mode
  vim.cmd.colorscheme(mode == "dark" and "habamax" or "shine")
end

apply_appearance()

vim.api.nvim_create_autocmd("FocusGained", {
  callback = apply_appearance,
})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { silent = true, desc = "Write buffer" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>", { silent = true, desc = "Quit window" })
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "File explorer" })

if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --smart-case"
  opt.grepformat = "%f:%l:%c:%m"
end
