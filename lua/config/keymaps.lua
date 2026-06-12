local map = vim.keymap.set

-- ─── Navigation buffers ───────────────────────────────────────
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Buffer précédent" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Buffer suivant" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Fermer buffer" })

-- ─── Déplacer des lignes en mode visuel ───────────────────────
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Déplacer ligne bas" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Déplacer ligne haut" })

-- ─── Sauvegarder ──────────────────────────────────────────────
map({ "n", "i" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Sauvegarder" })

-- ─── DevOps : Terraform ───────────────────────────────────────
map("n", "<leader>ti", "<cmd>!terraform init<cr>", { desc = "Terraform init" })
map("n", "<leader>tp", "<cmd>!terraform plan<cr>", { desc = "Terraform plan" })
map("n", "<leader>ta", "<cmd>!terraform apply<cr>", { desc = "Terraform apply" })
map("n", "<leader>tf", "<cmd>!terraform fmt %<cr>", { desc = "Terraform fmt" })

-- ─── DevOps : Kubernetes ──────────────────────────────────────
map("n", "<leader>ka", "<cmd>!kubectl apply -f %<cr>", { desc = "kubectl apply" })
map("n", "<leader>kd", "<cmd>!kubectl delete -f %<cr>", { desc = "kubectl delete" })
map("n", "<leader>kp", "<cmd>!kubectl get pods<cr>", { desc = "kubectl get pods" })

-- ─── DevOps : YAML ────────────────────────────────────────────
map("n", "<leader>yl", "<cmd>!yamllint %<cr>", { desc = "YAML lint" })

-- ─── Qualité de vie ───────────────────────────────────────────
map("n", "<leader>sr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Remplacer mot sous curseur" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Effacer surbrillance recherche" })
