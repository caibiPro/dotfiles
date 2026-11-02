-- habamax for a dark 'background', shine for a light one. Load the file
-- directly: a nested :colorscheme inside a colorscheme does not apply.
vim.cmd.runtime("colors/" .. (vim.o.background == "dark" and "habamax" or "shine") .. ".vim")
vim.g.colors_name = "auto"
