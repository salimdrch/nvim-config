local map = vim.keymap.set

-- ─── Base ─────────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>nohlsearch<cr>",           { desc = "Clear search" })
map("n", "<C-s>", "<cmd>w<cr>",                    { desc = "Sauvegarder" })
map("i", "jk",    "<Esc>",                         { desc = "Exit insert" })

-- ─── Navigation fenêtres ──────────────────────────────────────
map("n", "<C-h>", "<C-w>h",                        { desc = "Fenêtre gauche" })
map("n", "<C-j>", "<C-w>j",                        { desc = "Fenêtre bas" })
map("n", "<C-k>", "<C-w>k",                        { desc = "Fenêtre haut" })
map("n", "<C-l>", "<C-w>l",                        { desc = "Fenêtre droite" })

-- ─── Resize ───────────────────────────────────────────────────
map("n", "<C-Up>",    "<cmd>resize +2<cr>",        { desc = "Resize haut" })
map("n", "<C-Down>",  "<cmd>resize -2<cr>",        { desc = "Resize bas" })
map("n", "<C-Left>",  "<cmd>vertical resize -2<cr>", { desc = "Resize gauche" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Resize droite" })

-- ─── Buffers ──────────────────────────────────────────────────
map("n", "<S-h>",      "<cmd>bprevious<cr>",       { desc = "Buffer précédent" })
map("n", "<S-l>",      "<cmd>bnext<cr>",           { desc = "Buffer suivant" })
map("n", "<leader>bd", "<cmd>bdelete<cr>",         { desc = "Fermer buffer" })
map("n", "<leader>ba", "<cmd>%bdelete<cr>",        { desc = "Fermer tous buffers" })

-- ─── Splits ───────────────────────────────────────────────────
map("n", "<leader>sv", "<cmd>vsplit<cr>",          { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd>split<cr>",           { desc = "Split horizontal" })
map("n", "<leader>sx", "<cmd>close<cr>",           { desc = "Fermer split" })

-- ─── Édition ──────────────────────────────────────────────────
map("v", "J",          ":m '>+1<CR>gv=gv",        { desc = "Déplacer ligne bas" })
map("v", "K",          ":m '<-2<CR>gv=gv",        { desc = "Déplacer ligne haut" })
map("n", "<leader>sr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Remplacer mot" })

-- ─── Navigation mot par mot (WezTerm) ─────────────────────────
map("n", "<M-S-Right>", "vw",                      { desc = "Sélectionner mot droite" })
map("n", "<M-S-Left>",  "vb",                      { desc = "Sélectionner mot gauche" })
map("v", "<M-S-Right>", "w",                       { desc = "Étendre sélection droite" })
map("v", "<M-S-Left>",  "b",                       { desc = "Étendre sélection gauche" })

-- ─── DevOps : Terraform ───────────────────────────────────────
-- tf (fmt) et tv (validate) sont gérés par devops.quickfix (sortie structurée).
map("n", "<leader>ti", "<cmd>!terraform init<cr>",  { desc = "Terraform init" })
map("n", "<leader>tp", "<cmd>!terraform plan<cr>",  { desc = "Terraform plan" })
map("n", "<leader>ta", "<cmd>!terraform apply<cr>", { desc = "Terraform apply" })

-- ─── DevOps : Kubernetes ──────────────────────────────────────
map("n", "<leader>ka", "<cmd>!kubectl apply -f %<cr>",  { desc = "kubectl apply" })
map("n", "<leader>kd", "<cmd>!kubectl delete -f %<cr>", { desc = "kubectl delete" })
map("n", "<leader>kp", "<cmd>!kubectl get pods<cr>",    { desc = "kubectl get pods" })
map("n", "<leader>kn", "<cmd>!kubectl get nodes<cr>",   { desc = "kubectl get nodes" })

-- ─── DevOps : Ansible ─────────────────────────────────────────
-- al (lint) est géré par devops.quickfix (sortie structurée).
map("n", "<leader>ap", "<cmd>!ansible-playbook %<cr>",                { desc = "Ansible playbook" })
map("n", "<leader>as", "<cmd>!ansible-playbook % --syntax-check<cr>", { desc = "Ansible syntax check" })

-- ─── DevOps : YAML ────────────────────────────────────────────
-- yl (yamllint) est géré par devops.quickfix (sortie structurée).

-- ─── Git ──────────────────────────────────────────────────────
map("n", "<leader>gg", "<cmd>!lazygit<cr>",        { desc = "Lazygit" })

-- ─── Quickfix ─────────────────────────────────────────────────
map("n", "<leader>qo", "<cmd>copen<cr>",           { desc = "Ouvrir quickfix" })
map("n", "<leader>qc", "<cmd>cclose<cr>",          { desc = "Fermer quickfix" })
map("n", "]q",         "<cmd>cnext<cr>",           { desc = "Quickfix suivant" })
map("n", "[q",         "<cmd>cprev<cr>",           { desc = "Quickfix précédent" })

-- ─── Navigation rapide ────────────────────────────────────────
map({"n","v"}, "<Home>",    "^",        { desc = "Début de ligne (1er caractère)" })
map({"n","v"}, "<End>",     "$",        { desc = "Fin de ligne" })
map("n",       "<C-a>",     "ggVG",     { desc = "Sélectionner tout" })
map("n",       "<C-z>",     "u",        { desc = "Annuler" })
map("n",       "<C-y>",     "<C-r>",    { desc = "Rétablir" })
map("n",       "<C-d>",     "<C-d>zz",  { desc = "Demi-page bas (centré)" })
map("n",       "<C-u>",     "<C-u>zz",  { desc = "Demi-page haut (centré)" })

-- ─── Navigation mot par mot (Alt+Flèche, portable SSH/tmux) ──
map({"n","v"}, "<M-Right>", "w",  { desc = "Mot suivant" })
map({"n","v"}, "<M-Left>",  "b",  { desc = "Mot précédent" })
map("i",       "<M-Right>", "<C-o>w", { desc = "Mot suivant (insert)" })
map("i",       "<M-Left>",  "<C-o>b", { desc = "Mot précédent (insert)" })
