#!/bin/bash
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "🚀 Installation des dotfiles..."

cp "$DOTFILES/.tmux.conf" ~/.tmux.conf && echo "✅ tmux"

mkdir -p ~/.config/wezterm
cp "$DOTFILES/wezterm.lua" ~/.config/wezterm/wezterm.lua && echo "✅ WezTerm"

cp "$DOTFILES/.zprofile" ~/.zprofile && echo "✅ zprofile"
source ~/.zprofile

echo "✨ Done !"
