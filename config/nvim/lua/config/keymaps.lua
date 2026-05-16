-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Defer plugin requires until keypress so startup doesn't force-load DAP dependencies.
vim.keymap.set("n", "<leader>bk", function()
  require("goto-breakpoints").prev()
end, { desc = "Previous Breakpoint", noremap = true, silent = true })
vim.keymap.set("n", "<leader>bj", function()
  require("goto-breakpoints").next()
end, { desc = "Next Breakpoint", noremap = true, silent = true })
vim.keymap.set("n", "<leader>bs", function()
  require("goto-breakpoints").stopped()
end, { desc = "Stopped Breakpoint", noremap = true, silent = true })

-- Key mappings for snacks
vim.keymap.set("n", "<leader>gT", function()
  require("snacks").picker.git_diff()
end, { desc = "Git Diff (Hunks)", noremap = true, silent = true })

-- Key mappings for micropython_nvim
vim.keymap.set("n", "<leader>mr", function()
  require("micropython_nvim").run()
end, { desc = "Run MicroPython", noremap = true, silent = true })
vim.keymap.set("n", "<leader>mi", function()
  require("micropython_nvim").init()
end, { desc = "Init project", noremap = true, silent = true })
