-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set line numbbers to absolute
vim.opt.relativenumber = false
vim.diagnostic.config({
  update_in_insert = true, -- Show diagnostics while typing in insert mode
  virtual_text = true, -- Show inline error messages
  float = { border = "rounded" },
  severity_sort = true,
})
