-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Key mappings for goto-breakpoints
local bkps = require("goto-breakpoints")
vim.keymap.set("n", "<leader>bk", bkps.prev, {})
vim.keymap.set("n", "<leader>bj", bkps.next, {})
vim.keymap.set("n", "<leader>bs", bkps.stopped, {})

-- Key mappings for codewindow
local codewindow = require("codewindow")
vim.keymap.set("n", "<leader>mm", codewindow.toggle_minimap, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>mo", codewindow.open_minimap, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>mc", codewindow.close_minimap, { noremap = true, silent = true })

-- Key mappings for snacks
local snacks = require("snacks")
vim.keymap.set("n", "<leader>gT", snacks.picker.git_diff, { noremap = true, silent = true })
