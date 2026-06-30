#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT
cd "$TMP_DIR"

echo "==> Installation dans $BIN_DIR"

get_latest_version() {
  local version
  version=$(curl -s "https://api.github.com/repos/$1/releases/latest" \
    | grep -m1 '"tag_name"' \
    | grep -Po ':\s*"\K[^"]*')
  echo "$version"
}

install_tar() {
  local url="$1" bin="$2"
  curl -Lo archive.tar.gz "$url"
  local size
  size=$(stat -c%s archive.tar.gz 2>/dev/null || stat -f%z archive.tar.gz)
  if [ "$size" -lt 1024 ]; then
    echo "    Fichier suspect (<1Ko), probable erreur HTTP" >&2
    return 1
  fi
  tar xf archive.tar.gz --strip-components=1 -C "$BIN_DIR" --wildcards "*/${bin}" 2>/dev/null \
    || tar xf archive.tar.gz -C "$BIN_DIR" "$bin"
  chmod +x "$BIN_DIR/$bin"
  echo "    OK : $BIN_DIR/$bin"
  rm -f archive.tar.gz
}

# ─── ripgrep ────────────────────────────────────────────────────
if ! command -v rg >/dev/null 2>&1; then
  echo "--> ripgrep"
  V=$(get_latest_version "BurntSushi/ripgrep" || echo "15.1.0")
  install_tar \
    "https://github.com/BurntSushi/ripgrep/releases/download/${V}/ripgrep-${V}-x86_64-unknown-linux-musl.tar.gz" \
    "rg"
else
  echo "--> rg déjà présent ($(rg --version | head -1)), ignoré"
fi

# ─── fd ─────────────────────────────────────────────────────────
if ! command -v fd >/dev/null 2>&1; then
  echo "--> fd"
  V=$(get_latest_version "sharkdp/fd" || echo "v10.4.2")
  install_tar \
    "https://github.com/sharkdp/fd/releases/download/${V}/fd-${V}-x86_64-unknown-linux-musl.tar.gz" \
    "fd"
else
  echo "--> fd déjà présent ($(fd --version)), ignoré"
fi

# ─── lazygit ────────────────────────────────────────────────────
if ! command -v lazygit >/dev/null 2>&1; then
  echo "--> lazygit"
  V=$(get_latest_version "jesseduffield/lazygit" || echo "v0.62.2")
  VNUM="${V#v}"
  install_tar \
    "https://github.com/jesseduffield/lazygit/releases/download/${V}/lazygit_${VNUM}_linux_x86_64.tar.gz" \
    "lazygit"
else
  echo "--> lazygit déjà présent ($(lazygit --version | grep -Po 'version=\K[^,]*')), ignoré"
fi

# ─── PATH ───────────────────────────────────────────────────────
if ! grep -q '.local/bin' "$HOME/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
  echo "==> PATH mis à jour dans ~/.bashrc (relance : source ~/.bashrc)"
fi

echo ""
echo "==> Terminé."
echo "    rg      : $(rg --version | head -1)"
echo "    fd      : $(fd --version)"
echo "    lazygit : $(lazygit --version | grep -Po 'version=\K[^,]*')"

# ─── Neovim ─────────────────────────────────────────────────────
if ! command -v nvim >/dev/null 2>&1; then
  echo "--> neovim"
  curl -Lo /tmp/nvim.tar.gz \
    https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
  tar xf /tmp/nvim.tar.gz -C "$HOME/.local/"
  ln -sf "$HOME/.local/nvim-linux-x86_64/bin/nvim" "$BIN_DIR/nvim"
  echo "    OK : $(nvim --version | head -1)"
else
  echo "--> nvim déjà présent ($(nvim --version | head -1)), ignoré"
fi

# ─── Node.js (requis par Mason : pyright, yamlls, bashls, dockerls, ansiblels) ─
if ! command -v node >/dev/null 2>&1; then
  echo "--> node.js"
  NODE_VERSION="v22.13.1"
  curl -Lo /tmp/node.tar.gz \
    "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz"
  tar xf /tmp/node.tar.gz -C "$HOME/.local/" \
    --exclude="*/CHANGELOG.md" --exclude="*/LICENSE" --exclude="*/README.md"
  # Créer les symlinks dans ~/.local/bin
  ln -sf "$HOME/.local/node-${NODE_VERSION}-linux-x64/bin/node" "$BIN_DIR/node"
  ln -sf "$HOME/.local/node-${NODE_VERSION}-linux-x64/bin/npm" "$BIN_DIR/npm"
  ln -sf "$HOME/.local/node-${NODE_VERSION}-linux-x64/bin/npx" "$BIN_DIR/npx"
  echo "    OK : $(node --version)"
else
  echo "--> node déjà présent ($(node --version)), ignoré"
fi

# ─── tree-sitter CLI (requis par nvim-treesitter branche main) ──────────────
if ! command -v tree-sitter >/dev/null 2>&1; then
  echo "--> tree-sitter CLI"
  TS_VERSION=$(curl -s "https://api.github.com/repos/tree-sitter/tree-sitter/releases/latest" \
    | grep -m1 '"tag_name"' | grep -Po ':\s*"\K[^"]*' || echo "v0.26.9")
  curl -Lo /tmp/tree-sitter.gz \
    "https://github.com/tree-sitter/tree-sitter/releases/download/${TS_VERSION}/tree-sitter-linux-x64.gz"
  gunzip -c /tmp/tree-sitter.gz > "$BIN_DIR/tree-sitter"
  chmod +x "$BIN_DIR/tree-sitter"
  echo "    OK : $(tree-sitter --version)"
else
  echo "--> tree-sitter déjà présent ($(tree-sitter --version)), ignoré"
fi
