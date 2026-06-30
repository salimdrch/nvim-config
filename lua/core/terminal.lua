local M = {}

-- Terminal en split horizontal, toggle avec le même raccourci.
-- Un seul buffer réutilisé par session (pas un nouveau terminal à chaque appel).
function M.toggle()
  local term_buf = vim.g.devops_term_buf
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    local win = vim.fn.bufwinid(term_buf)
    if win ~= -1 then
      vim.api.nvim_win_close(win, false)
      return
    end
    vim.cmd("botright split")
    vim.api.nvim_win_set_buf(0, term_buf)
    vim.cmd("resize 15")
    vim.cmd("startinsert")
    return
  end

  vim.cmd("botright split")
  vim.cmd("resize 15")
  vim.cmd("terminal")
  vim.g.devops_term_buf = vim.api.nvim_get_current_buf()
end

function M.setup()
  vim.keymap.set("n", "<leader>tt", M.toggle, { desc = "Toggle terminal" })
  vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
  vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Fenêtre gauche (depuis terminal)" })
  vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Fenêtre bas (depuis terminal)" })
  vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Fenêtre haut (depuis terminal)" })
  vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Fenêtre droite (depuis terminal)" })

  vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("devops_terminal", { clear = true }),
    callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn = "no"
      vim.cmd("startinsert")
    end,
  })
end

return M
