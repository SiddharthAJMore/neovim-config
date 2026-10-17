local M = {}

-- Track globally to prevent duplicate setups
M.active_win = nil
M.active_buf = nil

-- Function to safely close the entire component
local function close_all()
  if M.active_win and vim.api.nvim_win_is_valid(M.active_win) then
    pcall(vim.api.nvim_win_close, M.active_win, true)
  end
  if M.active_buf and vim.api.nvim_buf_is_valid(M.active_buf) then
    pcall(vim.api.nvim_buf_delete, M.active_buf, { force = true })
  end
  M.active_win = nil
  M.active_buf = nil
end

function M.open_interactive_prompt()
  -- 1. If user presses leader+cx again, close the previous window cleanly first
  close_all()

  -- 2. Create a scratch buffer for entering the command
  local prompt_buf = vim.api.nvim_create_buf(false, true)
  M.active_buf = prompt_buf
  
  -- Calculate screen dimensions to center the window
  local ui = vim.api.nvim_list_uis()
  if not ui or #ui == 0 then return end
  local current_ui = ui[1]
  
  local width = math.floor(current_ui.width * 0.6)
  local height = 1
  local row = math.floor((current_ui.height - height) / 2)
  local col = math.floor((current_ui.width - width) / 2)

  local opts = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " Type Command ",
    title_pos = "center",
  }

  -- 3. Open the prompt window
  local win = vim.api.nvim_open_win(prompt_buf, true, opts)
  M.active_win = win
  vim.cmd("startinsert")

  -- 4. Handle Command Execution on Enter
  vim.keymap.set("i", "<CR>", function()
    -- Double-check that our current window context is still completely valid
    if not vim.api.nvim_win_is_valid(win) then return end

    local lines = vim.api.nvim_buf_get_lines(prompt_buf, 0, 1, false)
    local cmd = lines[1]

    vim.cmd("stopinsert")

    if not cmd or cmd == "" then
      close_all()
      return
    end

    -- 5. Create a FRESH, UNMODIFIED buffer for the terminal execution
    local term_buf = vim.api.nvim_create_buf(false, true)
    M.active_buf = term_buf

    -- 6. Resize the window and swap its buffer to the clean term_buf
    local target_height = math.floor(current_ui.height * 0.6)
    local target_row = math.floor((current_ui.height - target_height) / 2)
    
    -- Safely perform window transformations
    pcall(vim.api.nvim_win_set_buf, win, term_buf)
    pcall(vim.api.nvim_win_set_config, win, {
      relative = "editor",
      row = target_row,
      col = col,
      height = target_height,
      title = " Running: " .. cmd .. " ",
    })

    -- Safely delete the old prompt buffer now that the window is using term_buf
    if vim.api.nvim_buf_is_valid(prompt_buf) then 
      pcall(vim.api.nvim_buf_delete, prompt_buf, { force = true }) 
    end

    -- 7. Morph the clean buffer into an interactive terminal
    vim.fn.termopen(cmd, {
      on_exit = function(_, exit_code)
        pcall(function()
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_set_config(win, { 
              relative = "editor",
              row = target_row,
              col = col,
              title = " Process Finished (Code: " .. exit_code .. ") — Press Esc to Close " 
            })
          end
        end)
      end
    })

    -- Drop into terminal mode immediately so you can type inputs right away
    vim.cmd("startinsert")

    -- 8. Setup local window escape hatches inside the terminal buffer
    vim.keymap.set("t", "<Esc>", close_all, { buffer = term_buf, silent = true })
    vim.keymap.set("n", "<Esc>", close_all, { buffer = term_buf, silent = true })

  end, { buffer = prompt_buf, silent = true })

  -- Escape hatch for the initial prompt window
  vim.keymap.set("n", "<Esc>", close_all, { buffer = prompt_buf, silent = true })
end

-- Bind to a shortcut key combo
vim.keymap.set("n", "<leader>cx", M.open_interactive_prompt, { desc = "Interactive Floating Terminal" })

return M

