return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
  ███╗   ██╗██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██║   ██║██║████╗ ████║
  ██╔██╗ ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
       DevOps Engineer · Neovim]],
          keys = {
            { key = "f", desc = "Find File",       action = ":lua Snacks.dashboard.pick('files')" },
            { key = "r", desc = "Recent Files",    action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { key = "g", desc = "Find Text",       action = ":lua Snacks.dashboard.pick('live_grep')" },
            { key = "s", desc = "Restore Session", action = ":lua require('persistence').load()" },
            { key = "k", desc = "Kubernetes",      action = ":e ~/.kube/config" },
            { key = "c", desc = "Config Nvim",     action = ":cd ~/.config/nvim | e lua/config/keymaps.lua" },
            { key = "l", desc = "Lazy",            action = ":Lazy" },
            { key = "q", desc = "Quit",            action = ":qa" },
          },
        },
      },
    },
  },
}
