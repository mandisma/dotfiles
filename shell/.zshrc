# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

zshrc_target=$(readlink -f ~/.zshrc)
DOTFILES_DIRECTORY=$(cd `dirname $zshrc_target`/.. && pwd)
unset zshrc_target

ZSH_CUSTOM=$DOTFILES_DIRECTORY/misc/oh-my-zsh-custom

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME=""
eval "$(starship init zsh)"

# https://github.com/seebi/dircolors-solarized
# curl https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark --output ~/.dircolors
if [ -f ~/.dircolors ]; then
    eval `dircolors ~/.dircolors`
fi

# Hide username in prompt
DEFAULT_USER=`whoami`

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

if command -v composer &> /dev/null; then
    plugins+=("composer")
fi

if command -v nvm &> /dev/null; then
    plugins+=("nvm")
fi

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

if [ -f ~/.phpbrew/bashrc ]; then
    [[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
