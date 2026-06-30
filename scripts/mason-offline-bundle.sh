#!/usr/bin/env bash
# Génère un bundle Mason (binaires LSP/formatters) à transférer sur une VM
# sans accès Internet. À lancer sur un poste QUI A accès Internet.
#
# Usage : ./scripts/mason-offline-bundle.sh
# Résultat : ./mason-bundle.tar.gz à copier sur la VM cible (SCP/Ansible).

set -euo pipefail

MASON_PACKAGES=(
  terraformls yamlls bashls dockerls ansiblels pyright
  shfmt stylua black prettier
)

echo "==> Installation des paquets Mason : ${MASON_PACKAGES[*]}"
nvim --headless "+MasonInstall ${MASON_PACKAGES[*]}" +qa

MASON_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/mason"

if [ ! -d "$MASON_DIR" ]; then
  echo "Erreur : $MASON_DIR introuvable, l'installation Mason a probablement échoué." >&2
  exit 1
fi

OUT="mason-bundle.tar.gz"
echo "==> Archivage de $MASON_DIR vers $OUT"
tar czf "$OUT" -C "$(dirname "$MASON_DIR")" "$(basename "$MASON_DIR")"

echo ""
echo "Bundle créé : $OUT ($(du -h "$OUT" | cut -f1))"
echo ""
echo "Sur la VM cible (AVANT le premier lancement de Neovim) :"
echo "  scp $OUT user@vm-cible:/tmp/"
echo "  ssh user@vm-cible"
echo "  mkdir -p ~/.local/share/nvim"
echo "  tar xzf /tmp/$OUT -C ~/.local/share/nvim"
