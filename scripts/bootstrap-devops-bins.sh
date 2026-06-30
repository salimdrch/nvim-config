#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT
cd "$TMP_DIR"

echo "==> Installation dans $BIN_DIR"

get_latest_version() {
  curl -s "https://api.github.com/repos/$1/releases/latest" \
    | grep -m1 '"tag_name"' \
    | grep -Po ':\s*"\K[^"]*'
}

check_size() {
  local size
  size=$(stat -c%s "$1" 2>/dev/null || stat -f%z "$1")
  if [ "$size" -lt 1024 ]; then
    echo "    Fichier suspect (<1Ko) :" >&2
    cat "$1" >&2
    return 1
  fi
}

if ! command -v rg >/dev/null 2>&1; then
  echo "--> ripgrep"
  VERSION=$(get_latest_version "BurntSushi/ripgrep")
  curl -Lo archive.tar.gz \
    "https://github.com/BurntSushi/ripgrep/releases/download/${VERSION}/ripgrep-${VERSION}-x86_64-unknown-linux-musl.tar.gz"
  check_size archive.tar.gz
  tar xf archive.tar.gz --strip-components=1 -C "$BIN_DIR" --wildcards "*/rg"
  chmod +x "$BIN_DIR/rg"
  echo "    OK : $BIN_DIR/rg"
else
  echo "--> rg déjà présent, ignoré"
fi

if ! command -v fd >/dev/null 2>&1; then
  echo "--> fd"
  VERSION=$(get_latest_version "sharkdp/fd")
  # Retire le 'v' initial si présent pour construire le nom d'asset
  VNUM="${VERSION#v}"
  curl -Lo archive.tar.gz \
    "https://github.com/sharkdp/fd/releases/download/${VERSION}/fd-${VERSION}-x86_64-unknown-linux-musl.tar.gz"
  check_size archive.tar.gz
  tar xf archive.tar.gz --strip-components=1 -C "$BIN_DIR" --wildcards "*/fd"
  chmod +x "$BIN_DIR/fd"
  echo "    OK : $BIN_DIR/fd"
else
  echo "--> fd déjà présent, ignoré"
fi

if ! command -v lazygit >/dev/null 2>&1; then
  echo "--> lazygit"
  VERSION=$(get_latest_version "jesseduffield/lazygit")
  VNUM="${VERSION#v}"
  curl -Lo archive.tar.gz \
    "https://github.com/jesseduffield/lazygit/releases/download/${VERSION}/lazygit_${VNUM}_linux_x86_64.tar.gz"
  check_size archive.tar.gz
  tar xf archive.tar.gz -C "$BIN_DIR" lazygit
  chmod +x "$BIN_DIR/lazygit"
  echo "    OK : $BIN_DIR/lazygit"
else
  echo "--> lazygit déjà présent, ignoré"
fi

if ! grep -q '.local/bin' "$HOME/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
  echo "==> PATH mis à jour dans ~/.bashrc"
fi

echo ""
echo "==> Terminé. Vérifie avec :"
echo "    rg --version; fd --version; lazygit --version"
