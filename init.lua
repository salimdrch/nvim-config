-- ─── Garde de version minimale ────────────────────────────────
-- L'API LSP native (vim.lsp.config / vim.lsp.enable) nécessite >= 0.11.
if vim.fn.has("nvim-0.11") == 0 then
  vim.notify(
    "Cette configuration nécessite Neovim >= 0.11. Arrêt du chargement "
      .. "des plugins applicatifs (core.options/keymaps/autocmds restent actifs).",
    vim.log.levels.ERROR
  )
  return
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader avant tout
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.terminal").setup()
require("core.deps").setup()
require("devops.quickfix").setup()

-- Plugins
require("lazy").setup("plugins", {
  change_detection = { notify = false },
  rocks = { enabled = false },
  checker = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "tarPlugin", "tohtml",
        "tutor", "zipPlugin",
      },
    },
  },
})
