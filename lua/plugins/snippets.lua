return {
  -- Désactiver friendly-snippets
  {
    "rafamadriz/friendly-snippets",
    enabled = false,
  },

  -- LuaSnip : charge uniquement tes snippets custom
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })
    end,
  },

  -- blink.cmp : forcer l'utilisation de LuaSnip uniquement
  {
    "saghen/blink.cmp",
    opts = {
      snippets = {
        preset = "luasnip",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          snippets = {
            opts = {
              search_paths = { vim.fn.stdpath("config") .. "/snippets" },
              friendly_snippets = false,
            },
          },
        },
      },
    },
  },
}
