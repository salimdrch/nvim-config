return {
  -- File tree : affiche fichiers cachés
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },

  -- Terminal via snacks (déjà inclus dans LazyVim, on configure seulement)
  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
        win = { position = "bottom", height = 15 },
      },
    },
    keys = {
      { "<C-\\>", function() Snacks.terminal.toggle() end, desc = "Toggle Terminal", mode = { "n", "t" } },
    },
  },
}
