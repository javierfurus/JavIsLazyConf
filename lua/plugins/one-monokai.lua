return {
  "cpea2506/one_monokai.nvim",
  priority = 1000, -- make sure it loads before other UI plugins
  config = function()
    require("one_monokai").setup({
      transparent = false,
      colors = { bg = "#272528" },
      highlights = function(colors)
        return {}
      end,
      italics = true,
    })
    vim.cmd.colorscheme("one_monokai")
  end,
}
