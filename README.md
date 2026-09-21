# Dotfiles

Personal dotfiles for Fedora system customization.

## Key features

- **Management**: uses [GNU Stow](https://www.gnu.org/software/stow/) for symlink management.
- **Shell**: runs Zsh with [Antidote](https://github.com/mattmc3/antidote) plugins and the [Starship](https://starship.rs/) prompt.
- **Editor**: includes Vim with a custom statusline and optimized defaults.
- **Git**: uses [Delta](https://github.com/dandavison/delta) for diff viewing, rebase on pull, auto-stash, and local identity inclusion.
- **Command-line tools**:
    - `bat`: alternative to `cat`
    - `delta`: syntax-highlighting diff viewer
    - `zoxide`: fast directory jumper replacing `cd`
    - `fzf`: command-line fuzzy finder

## How to install

1. Clone this repository into `~/.dotfiles`.
2. Execute the `bootstrap.sh` script:

```bash
cd ~/.dotfiles
./bootstrap.sh
```

## Structure

Each top-level directory represents a Stow package:

```
.gitignore                  # Prevents committing unwanted files
bootstrap.sh                # Fedora setup script
git/                        # Git configuration
  .config/git/hooks/        # Global Git hooks (Vale commit-msg linting)
  .gitconfig                # Main git settings (delta, merge, rebase, aliases)
  .global-gitignore         # Global ignore patterns
starship/                   # Starship prompt config
  .config/starship.toml
vale/                       # Vale prose linter config
  .config/vale/.vale.ini
vim/                        # Vim configuration
  .vimrc
zsh/                        # Zsh configuration
  .zshrc                    # Main shell config (PATH, plugins, aliases)
  .zsh_plugins.txt          # Antidote plugin list
```

## Machine-specific customization

- **Git identity**: stored in `~/.gitconfig.local`, defining `[user] name` and `email`. The bootstrap script prompts for this automatically.
- **Shell overrides**: stored in `~/.zshrc.local` for custom paths or machine-specific environment variables. Sourced automatically by `.zshrc` when present.

## Stow packages

```bash
stow -R git starship vim zsh vale
```
