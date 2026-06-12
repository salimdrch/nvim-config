return {
  -- Formatting : déclare juste les formatters par filetype
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        terraform = { "terraform_fmt" },
        yaml      = { "prettier" },
        json      = { "prettier" },
        sh        = { "shfmt" },
        bash      = { "shfmt" },
        lua       = { "stylua" },
        markdown  = { "prettier" },
      },
    },
  },

  -- Diagnostics
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics fichier" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location list" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix list" },
    },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      },
      servers = {
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
              },
              validate = true,
              completion = true,
              hover = true,
            },
          },
        },
        terraformls = {
          filetypes = { "terraform", "tf", "terraform-vars" },
        },
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
        },
      },
    },
  },
}
