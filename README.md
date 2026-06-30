# Configuration Neovim — prérequis

## Version
- Neovim >= 0.11 (API LSP native `vim.lsp.config` / `vim.lsp.enable`).
  Une version inférieure affiche un message d'erreur au démarrage et arrête
  le chargement des plugins applicatifs.

## Binaires externes requis (critiques)
- `git`
- `rg` (ripgrep) — recherche fzf-lua
- `fzf` — sélecteur fzf-lua

## Binaires recommandés (dégradation gracieuse sinon)
- `fd` (ou `fdfind` sur Debian/Ubuntu) — find files plus rapide dans fzf-lua
- `lazygit` — `<leader>gg`
- `gcc` / `make` — compilation des parsers Treesitter (`:TSUpdate`)
- `terraform` (ou `tofu`), `ansible-lint`, `yamllint` — intégration quickfix DevOps
  (`<leader>tv`, `<leader>al`, `<leader>yl`)

## Police
Terminal client avec une **Nerd Font** installée (icônes mini.nvim /
nvim-web-devicons). Sans Nerd Font, désactiver les icônes dans
`mini.statusline.setup({ use_icons = false })`.

## Vérification
Après installation : `:CheckDevopsEnv` dans Neovim liste les binaires
manquants (critiques en rouge, optionnels en warning).

## Installation automatisée des binaires (sans sudo, portable)
```bash
./scripts/bootstrap-devops-bins.sh
```
Installe `rg`/`fd`/`lazygit` en espace utilisateur (`~/.local/bin`),
résolution dynamique des dernières versions via l'API GitHub. Fonctionne à
l'identique avec ou sans droits root — testé sur RHEL9.

## Environnement offline / verrouillé
Mason télécharge les binaires LSP/formatters depuis Internet au premier
lancement (`terraformls`, `yamlls`, `bashls`, `dockerls`, `ansiblels`,
`pyright`, `shfmt`, `stylua`, `black`, `prettier`).

Sur un poste sans accès Internet :
1. Sur un poste **avec** accès Internet :
   ```bash
   ./scripts/mason-offline-bundle.sh
   ```
2. Transférer le `mason-bundle.tar.gz` généré (SCP/Ansible) et l'extraire
   sur la VM cible **avant** le premier lancement de Neovim :
   ```bash
   tar xzf mason-bundle.tar.gz -C ~/.local/share/nvim
   ```
   Mason détecte les binaires déjà présents et ne tente pas de les
   retélécharger.
3. Intégrer ces deux scripts dans le playbook Ansible de provisioning des postes.

## Notes connues (rencontrées en conditions réelles)
- `nvim-treesitter` (branche `main`) a réécrit son API : plus de
  `nvim-treesitter.configs`, plus de `master` compatible avec Neovim >= 0.12.
  Highlight/indent sont activés via `vim.treesitter.start()` sur `FileType`
  (voir `lua/plugins/treesitter.lua`). Dépend désormais du binaire CLI
  `tree-sitter` (via `cargo install tree-sitter-cli` si absent).
- `ansible-lint` a supprimé `--parseable-severity` en v6.0.0 ; utiliser
  `-f pep8` (alias `-p`), déjà fait dans `lua/devops/quickfix.lua`.
