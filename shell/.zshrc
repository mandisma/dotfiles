# Standard shell variables
ZSH=$HOME/.oh-my-zsh
DOTFILES_DIRECTORY=$(cd `dirname $(readlink -f ~/.zshrc)`/.. && pwd)
ZSH_CUSTOM=$DOTFILES_DIRECTORY/misc/oh-my-zsh-custom
# Hide username in prompt
DEFAULT_USER=`whoami`

eval "$(starship init zsh)"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
    aliases
    fzf
    git
    copyfile
    zsh-syntax-highlighting
    zsh-autosuggestions
    colored-man-pages
)

command -v composer &> /dev/null && plugins+=("composer")
command -v nvm &> /dev/null && plugins+=("nvm")


# Load the shell dotfiles, and then some:
# * ~/.dotfiles-custom can be used for other settings you don’t want to commit.
for file in $DOTFILES_DIRECTORY/shell/.{exports,aliases,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done

for file in $DOTFILES_DIRECTORY/custom/shell/.{exports,aliases,functions,zshrc}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

unset file

source $ZSH/oh-my-zsh.sh
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# Loads nvm
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi
