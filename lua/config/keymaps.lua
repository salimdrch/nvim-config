-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- ─── Navigation buffers ───────────────────────────────────────
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Buffer précédent" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Buffer suivant" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Fermer buffer" })

-- ─── Déplacer des lignes en mode visuel ───────────────────────
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Déplacer ligne bas" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Déplacer ligne haut" })

-- ─── Sauvegarder ──────────────────────────────────────────────
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Sauvegarder" })

-- ─── Qualité de vie ───────────────────────────────────────────
map("n", "<leader>sr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Remplacer mot sous curseur" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Effacer surbrillance recherche" })
map("t", "<C-l>", "<C-l>", { desc = "Clear terminal" })

-- ─── Sessions ─────────────────────────────────────────────────
map("n", "<leader>qs", function()
  require("persistence").load()
end, { desc = "Restaurer session" })
map("n", "<leader>ql", function()
  require("persistence").load({ last = true })
end, { desc = "Dernière session" })
map("n", "<leader>qd", function()
  require("persistence").stop()
end, { desc = "Ne pas sauver la session" })

-- ─── Telescope avancé ─────────────────────────────────────────
local ok, builtin = pcall(require, "telescope.builtin")
if ok then
  -- Git
  map("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })
  map("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
  map("n", "<leader>gB", builtin.git_branches, { desc = "Git branches" })

  -- LSP
  map("n", "<leader>cs", builtin.lsp_document_symbols, { desc = "Symbols fichier" })
  map("n", "<leader>cS", builtin.lsp_workspace_symbols, { desc = "Symbols workspace" })
  map("n", "<leader>cr", builtin.lsp_references, { desc = "References" })

  -- Recherche avancée
  map("n", "<leader>s.", builtin.oldfiles, { desc = "Fichiers récents" })
  map("n", "<leader>sk", builtin.keymaps, { desc = "Keymaps" })
  map("n", "<leader>sd", builtin.diagnostics, { desc = "Diagnostics" })
  map("n", "<leader>sh", builtin.help_tags, { desc = "Aide nvim" })
end

-- ─── DevOps : Terraform ───────────────────────────────────────
map("n", "<leader>ti", "<cmd>!terraform init<cr>", { desc = "Terraform init" })
map("n", "<leader>tp", "<cmd>!terraform plan<cr>", { desc = "Terraform plan" })
map("n", "<leader>ta", "<cmd>!terraform apply<cr>", { desc = "Terraform apply" })
map("n", "<leader>tf", "<cmd>!terraform fmt %<cr>", { desc = "Terraform fmt" })

-- ─── DevOps : Kubernetes ──────────────────────────────────────
map("n", "<leader>ka", "<cmd>!kubectl apply -f %<cr>", { desc = "kubectl apply" })
map("n", "<leader>kd", "<cmd>!kubectl delete -f %<cr>", { desc = "kubectl delete" })
map("n", "<leader>kp", "<cmd>!kubectl get pods<cr>", { desc = "kubectl get pods" })

-- ─── DevOps : Ansible ─────────────────────────────────────────
map("n", "<leader>ap", "<cmd>!ansible-playbook %<cr>", { desc = "Ansible playbook" })
map("n", "<leader>al", "<cmd>!ansible-lint %<cr>", { desc = "Ansible lint" })
map("n", "<leader>as", "<cmd>!ansible-playbook % --syntax-check<cr>", { desc = "Ansible syntax check" })

-- ─── DevOps : YAML ────────────────────────────────────────────
map("n", "<leader>yl", "<cmd>!yamllint %<cr>", { desc = "YAML lint" })

-- ─── Sélection par mot (mode normal → visuel) ─────────────────
map("n", "<M-S-Right>", "vw", { desc = "Sélectionner mot droite" })
map("n", "M-S-Left>", "vb", { desc = "Sélectionner mot gauche" })

-- ─── Sélection étendue (mode visuel) ──────────────────────────
map("v", "<M-S-Right>", "w", { desc = "Étendre sélection droite" })
map("v", "<M-S-Left>", "b", { desc = "Étendre sélection gauche" })

-- ─── Ansible LSP toggle ───────────────────────────────────────
map("n", "<leader>aa", "<cmd>LspStart ansiblels<cr>", { desc = "Ansible LSP start" })
map("n", "<leader>ax", "<cmd>LspStop ansiblels<cr>",  { desc = "Ansible LSP stop" })
