-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Key mappings for goto-breakpoints
local bkps = require("goto-breakpoints")
vim.keymap.set("n", "<leader>bk", bkps.prev, { desc = "Previous Breakpoint", noremap = true, silent = true })
vim.keymap.set("n", "<leader>bj", bkps.next, { desc = "Next Breakpoint", noremap = true, silent = true })
vim.keymap.set("n", "<leader>bs", bkps.stopped, { desc = "Stopped Breakpoint", noremap = true, silent = true })

-- Key mappings for snacks
local snacks = require("snacks")
vim.keymap.set("n", "<leader>gT", snacks.picker.git_diff, { desc = "Git Diff (Hunks)", noremap = true, silent = true })

-- Key mappings for micropython_nvim
local mp = require("micropython_nvim")
vim.keymap.set("n", "<leader>mr", mp.run, { desc = "Run MicroPython", noremap = true, silent = true })
vim.keymap.set("n", "<leader>mi", mp.init, { desc = "Init project", noremap = true, silent = true })
