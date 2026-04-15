return {
  -- Mason : gestionnaire de LSP/linters/formatters
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP
        "terraform-ls",
        "yaml-language-server",
        "bash-language-server",
        "dockerfile-language-server",
        "helm-ls",
        -- Linters
        "tflint",
        "shellcheck",
        "yamllint",
        -- Formatters
        "prettier",
        "shfmt",
      },
    },
  },

  -- Treesitter : meilleure syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "terraform", "hcl",
        "yaml", "json", "toml",
        "bash", "dockerfile",
        "lua", "python",
        "markdown", "markdown_inline",
      },
    },
  },
}
