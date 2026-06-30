local M = {}

-- Binaires requis avec contexte d'usage, pour message d'erreur exploitable.
local REQUIRED_BINS = {
  { bin = "rg",           used_by = "fzf-lua (live_grep)",      critical = true },
  { bin = "fd",           used_by = "fzf-lua (find files)",     critical = false },
  { bin = "fzf",          used_by = "fzf-lua",                  critical = true },
  { bin = "git",          used_by = "gitsigns / git workflow",  critical = true },
  { bin = "lazygit",      used_by = "<leader>gg",                critical = false },
  { bin = "gcc",          used_by = "treesitter (compilation des parsers)", critical = false },
  { bin = "make",         used_by = "treesitter (:TSUpdate)",   critical = false },
  { bin = "tree-sitter",  used_by = "nvim-treesitter (branche main)", critical = false },
  { bin = "terraform",    used_by = "workflow Terraform",       critical = false },
  { bin = "ansible-lint", used_by = "workflow Ansible",         critical = false },
  { bin = "yamllint",     used_by = "workflow YAML",            critical = false },
}

function M.check(opts)
  opts = opts or {}
  local missing_critical, missing_optional = {}, {}

  for _, entry in ipairs(REQUIRED_BINS) do
    if vim.fn.executable(entry.bin) == 0 then
      table.insert(entry.critical and missing_critical or missing_optional, entry)
    end
  end

  if #missing_critical > 0 then
    local lines = { "Binaires CRITIQUES manquants :" }
    for _, e in ipairs(missing_critical) do
      table.insert(lines, ("  - %s (requis par : %s)"):format(e.bin, e.used_by))
    end
    vim.notify(table.concat(lines, "\n"), vim.log.levels.ERROR)
  end

  if opts.verbose and #missing_optional > 0 then
    local lines = { "Binaires optionnels manquants (fonctionnalités réduites) :" }
    for _, e in ipairs(missing_optional) do
      table.insert(lines, ("  - %s (requis par : %s)"):format(e.bin, e.used_by))
    end
    vim.notify(table.concat(lines, "\n"), vim.log.levels.WARN)
  end

  if opts.verbose and #missing_critical == 0 and #missing_optional == 0 then
    vim.notify("Tous les binaires connus sont présents.", vim.log.levels.INFO)
  end

  return missing_critical, missing_optional
end

function M.setup()
  -- Check non bloquant, différé pour ne pas ralentir le démarrage perçu.
  vim.defer_fn(function()
    M.check({ verbose = false })
  end, 200)

  vim.api.nvim_create_user_command("CheckDevopsEnv", function()
    M.check({ verbose = true })
  end, { desc = "Vérifie les binaires externes requis par la configuration" })
end

return M
