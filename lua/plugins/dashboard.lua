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
            { icon = " ", key = "f", desc = "Find File",        action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "r", desc = "Recent Files",     action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "g", desc = "Find Text",        action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "s", desc = "Restore Session",  action = ":lua require('persistence').load()" },
            { icon = "󱁤 ", key = "t", desc = "Terraform",        action = ":cd ~/tf-test | e main.tf" },
            { icon = "󱃾 ", key = "k", desc = "Kubernetes",       action = ":e ~/.kube/config" },
            { icon = " ", key = "c", desc = "Config Nvim",      action = ":cd ~/.config/nvim | e lua/config/keymaps.lua" },
            { icon = "󰒲 ", key = "l", desc = "Lazy",             action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit",             action = ":qa" },
          },
        },
      },
    },
  },
}
