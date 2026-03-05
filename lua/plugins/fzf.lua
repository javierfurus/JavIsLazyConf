return {
  "ibhagwan/fzf-lua",
  opts = {
    files = {
      -- Show gitignored and hidden files
      fd_opts = [[--color=never --type f --hidden --follow --no-ignore --exclude .git]],
      rg_opts = [[--color=never --files --hidden --follow --no-ignore -g '!.git']],
    },
    grep = {
      -- Show gitignored files in grep/live_grep
      rg_opts = [[--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --no-ignore --hidden -e]],
    },
  },
}
