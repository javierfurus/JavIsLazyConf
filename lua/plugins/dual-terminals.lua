return {
  {
    "dual-terminals",
    dir = vim.fn.stdpath("config"),
    config = function()
      -- Store terminal buffer numbers and window IDs
      local state = {
        bottom_buf = nil,
        right_buf = nil,
        bottom_win = nil,
        right_win = nil,
        visible = false,
      }

      -- Function to create terminals if they don't exist
      local function ensure_terminals()
        -- Check if bottom terminal buffer still exists
        if not state.bottom_buf or not vim.api.nvim_buf_is_valid(state.bottom_buf) then
          state.bottom_buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_call(state.bottom_buf, function()
            vim.fn.termopen(vim.o.shell, {
              env = { TERM = "xterm-256color" },
              clear_env = false,
            })
          end)
          -- Disable line numbers for bottom terminal
          vim.api.nvim_buf_set_option(state.bottom_buf, 'number', false)
          vim.api.nvim_buf_set_option(state.bottom_buf, 'relativenumber', false)
          vim.api.nvim_buf_set_option(state.bottom_buf, 'scrollback', 100000)
        end

        -- Check if right terminal buffer still exists
        if not state.right_buf or not vim.api.nvim_buf_is_valid(state.right_buf) then
          state.right_buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_call(state.right_buf, function()
            vim.fn.termopen(vim.o.shell, {
              env = { TERM = "xterm-256color" },
              clear_env = false,
            })
          end)
          -- Disable line numbers for right terminal
          vim.api.nvim_buf_set_option(state.right_buf, 'number', false)
          vim.api.nvim_buf_set_option(state.right_buf, 'relativenumber', false)
          vim.api.nvim_buf_set_option(state.right_buf, 'scrollback', 100000)
        end
      end

      -- Function to show bottom terminal
      local function show_bottom_terminal()
        ensure_terminals()

        if not state.bottom_win or not vim.api.nvim_win_is_valid(state.bottom_win) then
          -- Save current window
          local current_win = vim.api.nvim_get_current_win()

          -- Create bottom split (20% height)
          vim.cmd("botright split")
          state.bottom_win = vim.api.nvim_get_current_win()
          vim.api.nvim_win_set_buf(state.bottom_win, state.bottom_buf)
          vim.api.nvim_win_set_height(state.bottom_win, math.floor(vim.o.lines * 0.20))

          -- Disable line numbers and optimize for terminal rendering
          vim.api.nvim_win_set_option(state.bottom_win, 'number', false)
          vim.api.nvim_win_set_option(state.bottom_win, 'relativenumber', false)
          vim.api.nvim_win_set_option(state.bottom_win, 'signcolumn', 'no')
          vim.api.nvim_win_set_option(state.bottom_win, 'wrap', false)
          vim.api.nvim_win_set_option(state.bottom_win, 'scrolloff', 0)
          vim.api.nvim_win_set_option(state.bottom_win, 'sidescrolloff', 0)

          -- Return to the main window
          vim.api.nvim_set_current_win(current_win)
        end
      end

      -- Function to show right terminal
      local function show_right_terminal()
        ensure_terminals()

        if not state.right_win or not vim.api.nvim_win_is_valid(state.right_win) then
          -- Save current window
          local current_win = vim.api.nvim_get_current_win()

          -- Create right split (20% width)
          vim.cmd("botright vsplit")
          state.right_win = vim.api.nvim_get_current_win()
          vim.api.nvim_win_set_buf(state.right_win, state.right_buf)
          vim.api.nvim_win_set_width(state.right_win, math.floor(vim.o.columns * 0.20))

          -- Disable line numbers and optimize for terminal rendering
          vim.api.nvim_win_set_option(state.right_win, 'number', false)
          vim.api.nvim_win_set_option(state.right_win, 'relativenumber', false)
          vim.api.nvim_win_set_option(state.right_win, 'signcolumn', 'no')
          vim.api.nvim_win_set_option(state.right_win, 'wrap', false)
          vim.api.nvim_win_set_option(state.right_win, 'scrolloff', 0)
          vim.api.nvim_win_set_option(state.right_win, 'sidescrolloff', 0)

          -- Return to the main window
          vim.api.nvim_set_current_win(current_win)
        end
      end

      -- Function to show both terminals
      local function show_terminals()
        show_bottom_terminal()
        show_right_terminal()
        state.visible = true
      end

      -- Function to hide bottom terminal
      local function hide_bottom_terminal()
        if state.bottom_win and vim.api.nvim_win_is_valid(state.bottom_win) then
          vim.api.nvim_win_close(state.bottom_win, false)
          state.bottom_win = nil
        end
      end

      -- Function to hide right terminal
      local function hide_right_terminal()
        if state.right_win and vim.api.nvim_win_is_valid(state.right_win) then
          vim.api.nvim_win_close(state.right_win, false)
          state.right_win = nil
        end
      end

      -- Function to hide both terminals
      local function hide_terminals()
        hide_bottom_terminal()
        hide_right_terminal()
        state.visible = false
      end

      -- Function to toggle bottom terminal
      local function toggle_bottom_terminal()
        if state.bottom_win and vim.api.nvim_win_is_valid(state.bottom_win) then
          hide_bottom_terminal()
        else
          show_bottom_terminal()
        end
      end

      -- Function to toggle right terminal
      local function toggle_right_terminal()
        if state.right_win and vim.api.nvim_win_is_valid(state.right_win) then
          hide_right_terminal()
        else
          show_right_terminal()
        end
      end

      -- Function to toggle both terminals
      local function toggle_terminals()
        if state.visible then
          hide_terminals()
        else
          show_terminals()
        end
      end

      -- Show terminals on VimEnter
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          -- Delay slightly to ensure UI is ready
          vim.defer_fn(function()
            show_terminals()
          end, 100)
        end,
      })

      -- Set up keybindings
      vim.keymap.set("n", "<C-\\>", toggle_terminals, { noremap = true, silent = true, desc = "Toggle both terminals" })
      vim.keymap.set("n", "<leader>tt", toggle_bottom_terminal, { noremap = true, silent = true, desc = "Toggle bottom terminal" })
      vim.keymap.set("n", "<leader>ty", toggle_right_terminal, { noremap = true, silent = true, desc = "Toggle right terminal" })

      -- Optional: Set up keybindings to navigate to terminals
      vim.keymap.set("n", "<leader>tb", function()
        if state.bottom_win and vim.api.nvim_win_is_valid(state.bottom_win) then
          vim.api.nvim_set_current_win(state.bottom_win)
        end
      end, { noremap = true, silent = true, desc = "Go to bottom terminal" })

      vim.keymap.set("n", "<leader>tr", function()
        if state.right_win and vim.api.nvim_win_is_valid(state.right_win) then
          vim.api.nvim_set_current_win(state.right_win)
        end
      end, { noremap = true, silent = true, desc = "Go to right terminal" })
    end,
  },
}
