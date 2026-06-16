return {
  -- Mason
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "terraform-ls",
        "yaml-language-server",
        "bash-language-server",
        "ansible-language-server",
        "tflint",
        "shellcheck",
        "yamllint",
        "prettier",
        "shfmt",
      },
    },
  },

  -- Treesitter désactivé sur serveur (GLIBC trop vieux)
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = false,
  },
}
