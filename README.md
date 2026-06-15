# 🛠️ Neovim DevOps Config

Configuration Neovim complète orientée DevOps — LazyVim + LSP + tmux + SSH workflow.

## Stack

- **Editor** : Neovim + LazyVim
- **Terminal** : WezTerm + JetBrains Nerd Font
- **Plugin manager** : lazy.nvim
- **LSP** : Mason (Terraform, YAML, Bash, Dockerfile, Helm, Ansible)
- **Thème** : Catppuccin Mocha
- **Autocompletion** : blink.cmp + LuaSnip
- **Multiplexer** : tmux

---

## 🚀 Installation from scratch (Mac M1/M2)

### 1. Dépendances

```bash
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Neovim + outils essentiels
brew install neovim node lazygit ripgrep fd fzf tree-sitter ansible ansible-lint tmux

# WezTerm
brew install --cask wezterm

# Nerd Font
brew install --cask font-jetbrains-mono-nerd-font
```

### 2. Déployer la config

```bash
# Supprimer l'ancienne config si elle existe
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Cloner ce repo
git clone git@github.com:salimdrch/nvim-config.git ~/.config/nvim

# Installer les dotfiles (tmux, wezterm, zprofile)
~/.config/nvim/dotfiles/install.sh

# Lancer nvim — LazyVim s'installe automatiquement
nvim
```

Au premier lancement, LazyVim télécharge tous les plugins automatiquement. Attendre la fin de l'installation.

### 3. LSP via Mason

Mason installe automatiquement les LSP au premier lancement. Si certains manquent :

```
:MasonInstall yaml-language-server
:MasonInstall bash-language-server
:MasonInstall dockerfile-language-server
:MasonInstall ansible-language-server
```

LSP installés automatiquement :

- `terraform-ls` + `tflint`
- `yaml-language-server` + `yamllint`
- `bash-language-server` + `shellcheck` + `shfmt`
- `dockerfile-language-server`
- `helm-ls`
- `ansible-language-server` + `ansible-lint`
- `prettier`

---

## 💻 Installation par OS

### Ubuntu / Debian

```bash
# Neovim via binaire direct
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar -xzf nvim-linux-x86_64.tar.gz -C ~/.local
echo 'export PATH=$PATH:~/.local/nvim-linux-x86_64/bin' >> ~/.bashrc
source ~/.bashrc

# Dépendances
sudo apt install -y git curl nodejs npm tmux ripgrep fd-find

# Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name"' | sed -E 's/.*"v*([^"]+)".*/\1/')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# Déployer la config
git clone git@github.com:salimdrch/nvim-config.git ~/.config/nvim
~/.config/nvim/dotfiles/install.sh
nvim
```

### RHEL / CentOS (avec sudo)

```bash
# Neovim via binaire
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar -xzf nvim-linux-x86_64.tar.gz -C ~/.local
echo 'export PATH=$PATH:~/.local/nvim-linux-x86_64/bin' >> ~/.bashrc
source ~/.bashrc

# Dépendances
sudo yum install -y git curl nodejs tmux

# Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name"' | sed -E 's/.*"v*([^"]+)".*/\1/')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# Déployer la config
git clone git@github.com:salimdrch/nvim-config.git ~/.config/nvim
~/.config/nvim/dotfiles/install.sh
nvim
```

### RHEL / CentOS (sans sudo)

```bash
# Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar -xzf nvim-linux-x86_64.tar.gz -C ~/.local
echo 'export PATH=$PATH:~/.local/nvim-linux-x86_64/bin' >> ~/.bashrc

# Node.js sans sudo via nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.bashrc
nvm install --lts

# Lazygit sans sudo
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name"' | sed -E 's/.*"v*([^"]+)".*/\1/')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
mv lazygit ~/.local/bin/

source ~/.bashrc

# Déployer la config
git clone git@github.com:salimdrch/nvim-config.git ~/.config/nvim
~/.config/nvim/dotfiles/install.sh
nvim
```

### Windows (WSL2)

```powershell
# Installer WSL2 avec Ubuntu
wsl --install -d Ubuntu
# Puis dans WSL2, suivre les étapes Ubuntu/Debian
```

---

## 🔌 Workflow SSH + tmux

### Workflow quotidien

```bash
# Lancer ou reprendre la session principale
t

# Connexion SSH directe avec tmux
srv-awx        # SSH + tmux en une commande
k3s-nodes
vm-bastion-adm
```

### ~/.ssh/config

```
Host srv-awx
  HostName 10.10.16.3
  User adlere

Host k3s-nodes
  HostName 10.10.16.60
  User bastion

Host vm-tools
  HostName 10.10.16.19
  User adlere

Host vm-bastion-adm
  HostName 10.10.16.5
  User bastion
```

### ~/.zprofile — alias auto-générés

```bash
# Auto-génère un alias par host SSH
while IFS= read -r host; do
  alias "$host"="ssh $host -t 'tmux new-session -A -s main'"
done < <(grep "^Host " ~/.ssh/config | grep -v "\*" | awk '{print $2}')

# Aliases tmux
alias t="tmux new-session -A -s main"
alias ta="tmux attach -t"
alias tl="tmux list-sessions"
alias tk="tmux kill-session -t"
```

### tmux — raccourcis

> Prefix = `Ctrl+B`

| Raccourci | Action |
|---|---|
| `Ctrl+B` puis `-` | Split horizontal (terminal en dessous) |
| `Ctrl+B` puis `\|` | Split vertical |
| `Ctrl+B` puis `c` | Nouvelle fenêtre |
| `Ctrl+B` puis `n` / `p` | Fenêtre suivante / précédente |
| `Ctrl+B` puis `h/j/k/l` | Naviguer entre panes |
| `Ctrl+B` puis `H/J/K/L` | Redimensionner les panes |
| Clic souris | Switcher de pane |

---

## 📁 Structure de la config

```
~/.config/nvim/
├── init.lua                    # Entry point LazyVim
├── dotfiles/                   # Configs portables
│   ├── .tmux.conf              # Config tmux Catppuccin
│   ├── .zprofile               # Aliases SSH + tmux
│   ├── wezterm.lua             # Config WezTerm
│   └── install.sh              # Script déploiement automatique
├── snippets/
│   ├── terraform.json          # Snippets Terraform custom
│   └── yaml.json               # Snippets Kubernetes custom
└── lua/
    ├── config/
    │   ├── options.lua         # Options globales
    │   ├── keymaps.lua         # Keymaps custom
    │   └── autocmds.lua        # Autocommandes
    └── plugins/
        ├── dashboard.lua       # Dashboard custom DevOps
        ├── devops.lua          # Mason + Treesitter DevOps
        ├── editor.lua          # flash, surround, indent
        ├── git.lua             # Gitsigns + Lazygit
        ├── lint.lua            # nvim-lint
        ├── lsp.lua             # LSP + formatting + Ansible
        ├── navigation.lua      # Neo-tree
        ├── sessions.lua        # Persistence sessions
        ├── snippets.lua        # LuaSnip snippets custom
        ├── telescope.lua       # Telescope + fzf
        └── ui.lua              # Catppuccin + lualine + noice
```

---

## ✂️ Snippets disponibles

### Terraform

| Préfixe | Description |
|---|---|
| `tf_ec2` | Resource AWS EC2 instance |
| `tf_s3` | Resource AWS S3 bucket |
| `tf_var` | Variable Terraform |
| `tf_out` | Output Terraform |
| `tf_mod` | Module Terraform |
| `tf_provider` | Provider AWS |

### Kubernetes

| Préfixe | Description |
|---|---|
| `k8s_deploy` | Deployment |
| `k8s_svc` | Service |
| `k8s_cm` | ConfigMap |
| `k8s_secret` | Secret |
| `k8s_ingress` | Ingress |

---

## ⌨️ Keymaps essentiels

> Leader = `Space`

### Navigation

| Action | Raccourci |
|---|---|
| Chercher un fichier | `Space + Space` |
| Chercher dans les fichiers | `Space + /` |
| File tree | `Space + e` |
| Buffer précédent / suivant | `Shift+h` / `Shift+l` |
| Fermer buffer | `Space + b + d` |
| Split vertical | `Space + \|` |
| Split horizontal | `Space + -` |
| Navigation par mot | `Opt + ←/→` |
| Sélection par mot | `Opt + Shift + ←/→` |
| Flash jump | `s` + 2 lettres |

### LSP

| Action | Raccourci |
|---|---|
| Doc / infos | `K` |
| Aller à la définition | `g + d` |
| Renommer | `Space + c + r` |
| Actions de code | `Space + c + a` |
| Diagnostics | `Space + x + x` |
| Formatter | `Space + c + f` |
| Symbols fichier | `Space + c + s` |
| Symbols workspace | `Space + c + S` |

### Git

| Action | Raccourci |
|---|---|
| Lazygit | `Space + g + g` |
| Git blame ligne | `Space + g + b` |
| Git browse GitHub | `Space + g + B` |
| Git commits | `Space + g + c` |
| Git status | `Space + g + s` |
| Git branches | `Space + g + B` |

### Sessions

| Action | Raccourci |
|---|---|
| Restaurer session | `Space + q + s` |
| Dernière session | `Space + q + l` |
| Ne pas sauver | `Space + q + d` |

### Telescope

| Action | Raccourci |
|---|---|
| Fichiers récents | `Space + s + .` |
| Chercher keymap | `Space + s + k` |
| Diagnostics | `Space + s + d` |
| Aide nvim | `Space + s + h` |

### DevOps — Terraform

| Action | Raccourci |
|---|---|
| Terraform init | `Space + t + i` |
| Terraform plan | `Space + t + p` |
| Terraform apply | `Space + t + a` |
| Terraform fmt | `Space + t + f` |

### DevOps — Kubernetes

| Action | Raccourci |
|---|---|
| kubectl apply -f % | `Space + k + a` |
| kubectl delete -f % | `Space + k + d` |
| kubectl get pods | `Space + k + p` |

### DevOps — Ansible

| Action | Raccourci |
|---|---|
| Ansible playbook | `Space + a + p` |
| Ansible lint | `Space + a + l` |
| Ansible syntax check | `Space + a + s` |

### DevOps — YAML

| Action | Raccourci |
|---|---|
| YAML lint | `Space + y + l` |

### Outils

| Action | Raccourci |
|---|---|
| Sauvegarder | `Ctrl + S` |
| Remplacer mot sous curseur | `Space + s + r` |
| Effacer surbrillance | `Esc` |
| Déplacer ligne bas | `J` (visuel) |
| Déplacer ligne haut | `K` (visuel) |

### Dashboard

| Touche | Action |
|---|---|
| `f` | Chercher un fichier |
| `r` | Fichiers récents |
| `g` | Chercher dans les fichiers |
| `s` | Restaurer session |
| `k` | Ouvrir ~/.kube/config |
| `c` | Config Neovim |
| `l` | Lazy plugins |
| `q` | Quitter |

---

## 🎨 Thème

Catppuccin Mocha — cohérent entre nvim, WezTerm et tmux.

Config WezTerm (`dotfiles/wezterm.lua`) :

```lua
local wezterm = require("wezterm")
return {
  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size = 14.0,
  color_scheme = "Catppuccin Mocha",
  enable_tab_bar = true,
  use_fancy_tab_bar = false,
  window_padding = { left = 8, right = 8, top = 8, bottom = 8 },
  window_background_opacity = 0.95,
  keys = {
    { key = "s",          mods = "CTRL",      action = wezterm.action.SendKey { key = "s",          mods = "CTRL" } },
    { key = "b",          mods = "CTRL",      action = wezterm.action.SendKey { key = "b",          mods = "CTRL" } },
    { key = "LeftArrow",  mods = "OPT",       action = wezterm.action.SendKey { key = "b",          mods = "ALT" } },
    { key = "RightArrow", mods = "OPT",       action = wezterm.action.SendKey { key = "f",          mods = "ALT" } },
    { key = "LeftArrow",  mods = "OPT|SHIFT", action = wezterm.action.SendKey { key = "LeftArrow",  mods = "SHIFT|ALT" } },
    { key = "RightArrow", mods = "OPT|SHIFT", action = wezterm.action.SendKey { key = "RightArrow", mods = "SHIFT|ALT" } },
  },
}
```

---

## 🔧 Personnalisation

### Dashboard — modifier les raccourcis

Dans `lua/plugins/dashboard.lua` :

```lua
{ key = "p", desc = "Mon Projet", action = ":cd ~/projets/infra | e ." },
```

### Snippets — ajouter un template

Dans `snippets/terraform.json` ou `snippets/yaml.json` :

```json
"Mon Snippet": {
  "prefix": "mon_prefix",
  "body": [
    "ligne 1 ${1:placeholder}",
    "ligne 2 ${2:autre}"
  ]
}
```

### LSP — ajouter un serveur

Dans `lua/plugins/devops.lua` :

```lua
ensure_installed = {
  "mon-nouveau-lsp",
},
```

Dans `lua/plugins/lsp.lua` :

```lua
servers = {
  mon_lsp = {
    filetypes = { "ext1", "ext2" },
  },
},
```

### Keymaps — ajouter une commande

Dans `lua/config/keymaps.lua` :

```lua
map("n", "<leader>xx", "<cmd>!ma-commande<cr>", { desc = "Ma commande" })
```
