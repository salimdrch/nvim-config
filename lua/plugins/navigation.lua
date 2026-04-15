return {
  -- Meilleur file tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,  -- Affiche .env, .github, etc.
          hide_gitignored = false,
        },
      },
    },
  },

  -- Terminal intégré
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<C-\>]],
      direction = "horizontal",
      size = 15,
    },
  },
}
