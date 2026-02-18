return {
  "cpea2506/one_monokai.nvim",
  priority = 1000, -- make sure it loads before other UI plugins
  config = function()
    vim.cmd.colorscheme("one_monokai")
  end,
}
