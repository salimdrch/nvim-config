# 🛠️ Neovim DevOps Config

Configuration Neovim complète orientée DevOps — LazyVim + LSP + SSH workflow.

## Stack

- **Editor** : Neovim + LazyVim
- **Terminal** : WezTerm + JetBrains Nerd Font
- **Plugin manager** : lazy.nvim
- **LSP** : Mason (Terraform, YAML, Bash, Dockerfile, Helm)

---

## 🚀 Installation from scratch (Mac M1/M2)

### 1. Dépendances

```bash
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Neovim
brew install neovim

# Node.js (requis pour les LSP)
brew install node

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

# Lancer nvim — LazyVim s'installe automatiquement
nvim
```

Au premier lancement, LazyVim télécharge tous les plugins automatiquement. Attendre la fin de l'installation.

### 3. Installer les LSP via Mason

Dans nvim :

```
:Mason
```

Les LSP suivants doivent être installés :
- `terraform-ls`
- `yaml-language-server`
- `bash-language-server`
- `dockerfile-language-server`
- `helm-ls`
- `tflint`
- `shellcheck`
- `shfmt`
- `yamllint`

Si certains manquent :

```
:MasonInstall yaml-language-server
:MasonInstall bash-language-server
:MasonInstall dockerfile-language-server
```

---

## 🖥️ Installation sur VM RHEL (sans sudo)

```bash
# Télécharger le binaire Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar -xzf nvim-linux-x86_64.tar.gz -C ~/.local

# Ajouter au PATH
echo 'export PATH=$PATH:~/.local/nvim-linux-x86_64/bin' >> ~/.bashrc
source ~/.bashrc

# Vérifier
nvim --version | head -1

# Installer tmux (avec sudo)
sudo yum install tmux

# Déployer la config
git clone git@github.com:salimdrch/nvim-config.git ~/.config/nvim
nvim
```

---

## 🔌 Workflow SSH + tmux

### ~/.ssh/config

```
Host vm-bastion-adm
  HostName 10.10.6.5
  User bastion
```

### ~/.zprofile — alias auto-générés

```bash
# Auto-génère un alias par host SSH
while IFS= read -r host; do
  alias "$host"="ssh $host -t 'tmux new-session -A -s main'"
done < <(grep "^Host " ~/.ssh/config | grep -v "\*" | awk '{print $2}')
```

Connexion en une commande :

```bash
srv-awx
k3s-nodes
vm-bastion-adm
```

---

## ⌨️ Keymaps essentiels

> Leader = `Space`

| Action | Raccourci |
|---|---|
| File tree | `Space + e` |
| Chercher un fichier | `Space + Space` |
| Chercher dans les fichiers | `Space + /` |
| Terminal | `Ctrl + \` |
| Lazygit | `Space + g + g` |
| LSP hover doc | `K` |
| Go to definition | `g + d` |
| Rename variable | `Space + c + r` |
| Diagnostics | `Space + x + x` |
| Copier vers clipboard Mac | `"+y` |
| Coller depuis clipboard Mac | `"+p` |

---

## 📁 Structure de la config

```
~/.config/nvim/
├── init.lua                  # Entry point LazyVim
├── lua/
│   ├── config/
│   │   ├── options.lua       # Options globales (clipboard, etc.)
│   │   ├── keymaps.lua       # Keymaps custom
│   │   └── autocmds.lua      # Autocommands
│   └── plugins/
│       ├── devops.lua        # LSP + Treesitter DevOps
│       ├── navigation.lua    # Neo-tree + Toggleterm
│       ├── git.lua           # Lazygit
│       └── options.lua       # Options plugins
```
