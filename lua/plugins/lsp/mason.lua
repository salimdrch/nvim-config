return {
  -- ─── Mason ──────────────────────────────────────────────────
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },

  -- ─── Mason-lspconfig ────────────────────────────────────────
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = function()
      return { ensure_installed = require("core.lsp.servers").list }
    end,
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
      require("core.lsp.diagnostics").setup()
      require("core.lsp.servers").configure()
      -- Même liste que ensure_installed : plus de risque de désync.
      vim.lsp.enable(require("core.lsp.servers").list)
    end,
  },
}
