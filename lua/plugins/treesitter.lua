return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    -- NB: l'ancienne API (main = "nvim-treesitter.configs", opts = {highlight=...})
    -- n'existe plus depuis la réécriture de nvim-treesitter (branche `main`).
    -- Le plugin ne gère désormais QUE l'installation des parsers ; highlight/indent
    -- s'activent nous-mêmes via vim.treesitter.start() sur FileType.
    init = function()
      local ensure_installed = {
        "yaml", "json", "toml",
        "bash", "lua", "python",
        "markdown", "markdown_inline",
        "vim", "vimdoc",
      }

      local max_filesize = 500 * 1024
      local function buffer_too_big(buf)
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        return ok and stats and stats.size > max_filesize
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
        callback = function(event)
          if buffer_too_big(event.buf) then
            return
          end

          -- Highlighting natif (remplace highlight.enable=true de l'ancienne API)
          pcall(vim.treesitter.start)

          -- Indentation basée sur treesitter (remplace indent.enable=true)
          vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- Installe les parsers manquants au démarrage, sans bloquer l'UI.
      vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
          local ok, ts = pcall(require, "nvim-treesitter")
          if not ok then
            return
          end
          local installed = require("nvim-treesitter.config").get_installed()
          local missing = vim.tbl_filter(function(parser)
            return not vim.tbl_contains(installed, parser)
          end, ensure_installed)
          if #missing > 0 then
            ts.install(missing)
          end
        end,
      })
    end,
  },
}
