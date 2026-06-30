return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      -- Pas de format_on_save synchrone bloquant sur les gros fichiers IaC.
      -- Au-delà de 2000 lignes : pas de format auto, fallback manuel <leader>cf.
      format_on_save = function(bufnr)
        local max_lines = 2000
        if vim.api.nvim_buf_line_count(bufnr) > max_lines then
          return nil
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
      formatters_by_ft = {
        terraform = { "terraform_fmt" },
        yaml      = { "prettier" },
        json      = { "prettier" },
        sh        = { "shfmt" },
        bash      = { "shfmt" },
        lua       = { "stylua" },
        python    = { "black" },
        markdown  = { "prettier" },
      },
    },
  },
}
