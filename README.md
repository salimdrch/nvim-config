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
