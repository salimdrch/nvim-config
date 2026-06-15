
eval "$(/opt/homebrew/bin/brew shellenv)"

# Auto-génère un alias par host SSH
while IFS= read -r host; do
  alias "$host"="ssh $host -t 'tmux new-session -A -s main'"
done < <(grep "^Host " ~/.ssh/config | grep -v "\*" | awk '{print $2}')

autoload -Uz compinit
compinit

# Ajoute dans ~/.zprofile
zstyle ':completion:*:ssh:*' hosts $(grep "^Host " ~/.ssh/config | grep -v "\*" | awk '{print $2}')

# ─── Tmux ─────────────────────────────────────────────────────
alias t="tmux new-session -A -s main"
alias ta="tmux attach -t"
alias tl="tmux list-sessions"
alias tk="tmux kill-session -t"
