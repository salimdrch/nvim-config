return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    event = "InsertEnter",
    config = function()
      local ls = require("luasnip")

      -- Charge tous les snippets JSON custom (yaml.json, terraform.json,
      -- ansible.json) — plus aucun snippet en dur en Lua dans ce fichier.
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })

      -- Keymaps LuaSnip
      local map = vim.keymap.set
      map({ "i", "s" }, "<Tab>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
      end, { desc = "Snippet expand/jump" })

      map({ "i", "s" }, "<S-Tab>", function()
        if ls.jumpable(-1) then ls.jump(-1) end
      end, { desc = "Snippet jump back" })
    end,
  },
}
