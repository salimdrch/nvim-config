#!/usr/bin/env bash
# Installe rg/fd/lazygit en espace utilisateur (~/.local/bin), sans sudo.
# Fonctionne identiquement avec ou sans droits root — portable sur tout poste.
# fzf est volontairement omis ici : souvent déjà packagé (dnf/apt), à
# vérifier au cas par cas avec `which fzf` avant de le retélécharger.
#
# Usage : ./scripts/bootstrap-devops-bins.sh

set -euo pipefail

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT
cd "$TMP_DIR"

echo "==> Installation dans $BIN_DIR"

install_from_github_tar() {
  local repo="$1" asset_pattern="$2" strip_components="$3" wanted_bin="$4"

  echo "--> $repo"
  local version
  version=$(curl -s "https://api.github.com/repos/${repo}/releases/latest" \
    | grep -Po '"tag_name": "\K[^"]*')
  if [ -z "$version" ]; then
    echo "    Impossible de résoudre la dernière version pour $repo" >&2
    return 1
  fi

  local url
  url=$(curl -s "https://api.github.com/repos/${repo}/releases/latest" \
    | grep -Po '"browser_download_url": "\K[^"]*'"${asset_pattern}"'[^"]*' \
    | head -1)
  if [ -z "$url" ]; then
    echo "    Aucun asset correspondant à '${asset_pattern}' trouvé pour $repo $version" >&2
    return 1
  fi

  echo "    Téléchargement : $url"
  curl -Lo archive.tar.gz "$url"

  if [ "$(stat -c%s archive.tar.gz 2>/dev/null || stat -f%z archive.tar.gz)" -lt 1024 ]; then
    echo "    Fichier suspect (<1Ko), probable erreur HTTP :" >&2
    cat archive.tar.gz >&2
    return 1
  fi

  if [ "$strip_components" -gt 0 ]; then
    tar xf archive.tar.gz --strip-components="$strip_components" -C "$BIN_DIR" --wildcards "*/${wanted_bin}"
  else
    tar xf archive.tar.gz -C "$BIN_DIR" "$wanted_bin"
  fi
  chmod +x "$BIN_DIR/$wanted_bin"
  rm -f archive.tar.gz
  echo "    OK : $BIN_DIR/$wanted_bin"
}

if ! command -v rg >/dev/null 2>&1; then
  install_from_github_tar "BurntSushi/ripgrep" "musl.tar.gz" 1 "rg" || true
else
  echo "--> rg déjà présent, ignoré"
fi

if ! command -v fd >/dev/null 2>&1; then
  install_from_github_tar "sharkdp/fd" "musl.tar.gz" 1 "fd" || true
else
  echo "--> fd déjà présent, ignoré"
fi

if ! command -v lazygit >/dev/null 2>&1; then
  install_from_github_tar "jesseduffield/lazygit" "Linux_x86_64.tar.gz" 0 "lazygit" || true
else
  echo "--> lazygit déjà présent, ignoré"
fi

if ! grep -q '.local/bin' "$HOME/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
  echo "==> PATH mis à jour dans ~/.bashrc (relance ton shell ou: source ~/.bashrc)"
fi

echo ""
echo "==> Terminé. Vérifie avec :"
echo "    rg --version; fd --version; lazygit --version"
