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

local is_mac = vim.fn.has("mac") == 1

if is_mac then
  local function apply_appearance()
    -- macOS: "Dark" in dark mode, error/empty in light mode
    local out = vim.trim(vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null"))
    opt.background = out == "Dark" and "dark" or "light"
  end

  apply_appearance()

  vim.api.nvim_create_autocmd("FocusGained", {
    callback = apply_appearance,
  })
else
  -- Elsewhere (e.g. over SSH) follow the terminal. Nvim sets 'background' from
  -- the terminal's OSC 11 reply before this file runs, but only waits 100 ms:
  -- over a slow SSH link the reply comes late, and tmux before 3.4 does not
  -- pass on the outer terminal's color. Remember the last good reply and start
  -- from it in those cases, so the first frame does not flash.
  local cache = vim.fn.stdpath("state") .. "/background"
  local in_tmux = vim.env.TMUX ~= nil

  local function remember(bg)
    if not in_tmux then
      pcall(vim.fn.writefile, { bg }, cache)
    end
  end

  if vim.api.nvim_get_option_info2("background", {}).was_set and not in_tmux then
    remember(vim.o.background)
  else
    local ok, lines = pcall(vim.fn.readfile, cache)
    if ok and (lines[1] == "dark" or lines[1] == "light") then
      opt.background = lines[1]
    end
  end

  -- Nvim asks the terminal again when it reports a theme switch, but drops its
  -- own reply handler once a Vim-script colorscheme has set 'background'.
  -- Handle the replies here instead.
  vim.api.nvim_create_autocmd("TermResponse", {
    callback = function(ev)
      local r, g, b = ev.data.sequence:match("^\027%]11;rgba?:(%x+)/(%x+)/(%x+)")
      if r then
        local function level(hex)
          return tonumber(hex, 16) / (16 ^ #hex - 1)
        end
        local luminance = 0.299 * level(r) + 0.587 * level(g) + 0.114 * level(b)
        opt.background = luminance < 0.5 and "dark" or "light"
        remember(vim.o.background)
      end
    end,
  })
end

-- colors/auto.lua picks habamax (dark) or shine (light) from 'background';
-- Nvim reloads it whenever 'background' changes. Load it last: the check
-- above needs 'background' as Nvim's startup detection left it.
vim.cmd.colorscheme("auto")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { silent = true, desc = "Write buffer" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>", { silent = true, desc = "Quit window" })
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "File explorer" })

if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --smart-case"
  opt.grepformat = "%f:%l:%c:%m"
end
