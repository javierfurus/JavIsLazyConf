-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-Left>", "<C-o>", { desc = "Jump to previous location" })
vim.keymap.set("n", "<C-Right>", "<C-i>", { desc = "Jump to next location" })
vim.keymap.set("i", "<C-z>", "<C-o>u", { desc = "Undo in insert mode" })

