# Environment & Shell Variables
export DOTFILES_DIRECTORY="${DOTFILES_DIRECTORY:-$HOME/.dotfiles}"
export LANG="en_US.UTF-8"
export EDITOR="vim"
export LESS_TERMCAP_md=$'\e[1;33m'

# PNPM Setup
export PNPM_HOME="$HOME/.local/share/pnpm"

# PATH Environment Setup
typeset -U path  # Keep PATH clean by enforcing unique entries in Zsh

path=(
    "$HOME/.local/bin"
    "$HOME/.npm-global/bin"
    "$PNPM_HOME"
    "$HOME/.composer/vendor/bin"
    "$HOME/.local/share/JetBrains/Toolbox/scripts"
    "$HOME/.opencode/bin"
    $path
)

# Antidote (Zsh Plugin Manager)
ANTIDOTE_DIR="$HOME/.antidote"
if [[ -f "$ANTIDOTE_DIR/antidote.zsh" ]]; then
    source "$ANTIDOTE_DIR/antidote.zsh"
    mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/antidote"
    antidote load "$HOME/.zsh_plugins.txt" "${XDG_CACHE_HOME:-$HOME/.cache}/antidote/zsh_plugins.zsh"
fi

# History Settings
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS    # Don't record an entry that was just recorded.
setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks.
setopt HIST_IGNORE_SPACE       # Don't record entries starting with a space.
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicate entries first.
setopt SHARE_HISTORY           # Share history between all sessions.
setopt INC_APPEND_HISTORY      # Write to history file immediately.
setopt HIST_FIND_NO_DUPS       # Do not display duplicate search lines.
setopt autocd                  # Automatically cd into typed directories.

export HISTORY_IGNORE="(ls|cd|cd -|pwd|exit|date|* --help)"

# Aliases
alias ll="ls -l"
alias la="ls -al"
alias l="ls -al"
alias cat="bat"
alias hostfile="sudoedit /etc/hosts"
alias sshconfig="vim ~/.ssh/config"
alias zshconfig="vim ~/.zshrc"
alias zshreload="source ~/.zshrc"
alias p="cd ~/Projects"
alias ggone="git gone"

# Tool Initializations
command -v starship &>/dev/null && eval "$(starship init zsh)"
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh --cmd cd)"
fi

# Machine-local overrides
[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
