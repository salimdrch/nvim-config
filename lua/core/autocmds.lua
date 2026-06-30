local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- ─── Highlight au yank ────────────────────────────────────────
autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- ─── Resize splits automatique ────────────────────────────────
autocmd("VimResized", {
  group = augroup("resize_splits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- ─── Retour à la dernière position dans le fichier ────────────
autocmd("BufReadPost", {
  group = augroup("last_position", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- ─── Fermer certains filetypes avec q ─────────────────────────
autocmd("FileType", {
  group = augroup("close_with_q", { clear = true }),
  pattern = { "help", "man", "qf", "checkhealth", "lspinfo" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf })
  end,
})

-- ─── Filetypes DevOps ─────────────────────────────────────────
autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("devops_filetypes", { clear = true }),
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.bo.filetype = "terraform"
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("ansible_filetypes", { clear = true }),
  pattern = {
    "*/playbooks/*.yml",
    "*/playbooks/*.yaml",
    "*/roles/*/tasks/*.yml",
    "*/roles/*/handlers/*.yml",
    "*/roles/*/defaults/*.yml",
    "*playbook*.yml",
    "site.yml",
  },
  callback = function()
    vim.bo.filetype = "yaml.ansible"
  end,
})

-- ─── Supprime espaces en fin de ligne à la sauvegarde ─────────
autocmd("BufWritePre", {
  group = augroup("trim_whitespace", { clear = true }),
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})
