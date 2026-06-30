local M = {}

-- Exécute une commande shell de façon asynchrone, pousse la sortie dans la
-- quickfix list selon l'errorformat fourni, puis ouvre la quickfix si non vide.
local function run_to_quickfix(cmd, efm, title)
  vim.notify("Exécution : " .. cmd, vim.log.levels.INFO)
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data) M._buf = M._buf or {}; vim.list_extend(M._buf, data or {}) end,
    on_stderr = function(_, data) M._buf = M._buf or {}; vim.list_extend(M._buf, data or {}) end,
    on_exit = function(_, code)
      vim.schedule(function()
        local out = vim.tbl_filter(function(l) return l ~= "" end, M._buf or {})
        M._buf = nil

        local saved_efm = vim.o.errorformat
        vim.o.errorformat = efm
        vim.fn.setqflist({}, " ", { title = title, lines = out })
        vim.o.errorformat = saved_efm

        if #vim.fn.getqflist() > 0 then
          vim.cmd("copen")
        elseif code == 0 then
          vim.notify(title .. " : OK, aucune erreur", vim.log.levels.INFO)
        else
          vim.notify(
            title .. " : échec (code " .. code .. "), sortie non parseable — voir :messages",
            vim.log.levels.WARN
          )
        end
      end)
    end,
  })
end

-- ─── Terraform / OpenTofu ───────────────────────────────────────
function M.terraform_validate()
  if vim.fn.executable("terraform") == 0 then
    vim.notify("terraform introuvable dans le PATH", vim.log.levels.ERROR)
    return
  end

  local ok, result = pcall(vim.fn.system, "terraform validate -json")
  if not ok then
    vim.notify("Échec de l'exécution de terraform validate", vim.log.levels.ERROR)
    return
  end

  local decoded_ok, decoded = pcall(vim.json.decode, result)
  if not decoded_ok then
    vim.notify("Sortie terraform validate non JSON, vérifiez la version de terraform", vim.log.levels.WARN)
    return
  end

  local qf_items = {}
  for _, diag in ipairs(decoded.diagnostics or {}) do
    local range = diag.range
    table.insert(qf_items, {
      filename = range and range.filename or vim.fn.expand("%"),
      lnum = range and range.start.line or 1,
      col = range and range.start.column or 1,
      text = diag.summary .. (diag.detail and (" — " .. diag.detail) or ""),
      type = diag.severity == "error" and "E" or "W",
    })
  end

  vim.fn.setqflist(qf_items, "r")
  vim.fn.setqflist({}, "a", { title = "terraform validate" })

  if #qf_items > 0 then
    vim.cmd("copen")
  else
    vim.notify("terraform validate : OK", vim.log.levels.INFO)
  end
end

function M.terraform_fmt()
  if vim.fn.executable("terraform") == 0 then
    vim.notify("terraform introuvable dans le PATH", vim.log.levels.ERROR)
    return
  end
  vim.cmd("silent !terraform fmt %")
  vim.cmd("edit!")
  vim.notify("terraform fmt appliqué", vim.log.levels.INFO)
end

-- ─── Ansible lint ───────────────────────────────────────────────
function M.ansible_lint()
  if vim.fn.executable("ansible-lint") == 0 then
    vim.notify("ansible-lint introuvable dans le PATH", vim.log.levels.WARN)
    return
  end
  -- Format pep8 : "file:line: [code] message" -> compatible errorformat direct
  run_to_quickfix(
    "ansible-lint --parseable-severity " .. vim.fn.shellescape(vim.fn.expand("%")),
    "%f:%l: [%t] %m,%f:%l:%c: [%t] %m",
    "ansible-lint"
  )
end

-- ─── YAML lint ────────────────────────────────────────────────
function M.yamllint()
  if vim.fn.executable("yamllint") == 0 then
    vim.notify("yamllint introuvable dans le PATH", vim.log.levels.WARN)
    return
  end
  -- yamllint -f parsable : "file:line:col: [level] message (rule)"
  run_to_quickfix(
    "yamllint -f parsable " .. vim.fn.shellescape(vim.fn.expand("%")),
    "%f:%l:%c: [%t] %m",
    "yamllint"
  )
end

function M.setup()
  local map = vim.keymap.set
  map("n", "<leader>tv", M.terraform_validate, { desc = "Terraform validate → quickfix" })
  map("n", "<leader>tf", M.terraform_fmt,      { desc = "Terraform fmt" })
  map("n", "<leader>al", M.ansible_lint,       { desc = "Ansible lint → quickfix" })
  map("n", "<leader>yl", M.yamllint,           { desc = "YAML lint → quickfix" })
end

return M
