return {
  "polarmutex/git-worktree.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope.nvim", optional = true },
  },
  -- ensure defaults before plugin loads
  init = function()
    vim.g.git_worktree = vim.g.git_worktree or {}
  end,
  config = function()
    local ok = pcall(require, "telescope")
    if ok then
      pcall(require("telescope").load_extension, "git_worktree")
    end
  end,
}
