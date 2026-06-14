return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufReadPost" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        yaml      = { "yamllint" },
        terraform = { "tflint" },
        sh        = { "shellcheck" },
        bash      = { "shellcheck" },
      }

      -- Lance le lint à la sauvegarde
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
