# Dotfiles

Personal dotfiles for Fedora system customization.

## Key Features

- **Management**: [GNU Stow](https://www.gnu.org/software/stow/) for symlink management.
- **Shell**: Zsh with [Antidote](https://github.com/mattmc3/antidote) (plugin manager) and [Starship](https://starship.rs/) prompt.
- **Editor**: Vim with statusline and optimized defaults.
- **Git**: [Delta](https://github.com/dandavison/delta) for diff viewer, rebase on pull, auto-stash, and local identity inclusion.
- **CLI Tools**:
    - `bat` (cat replacement)
    - `delta` (diff viewer)
    - `zoxide` (cd replacement)
    - `fzf` (fuzzy finder)

## How to Install

1. Clone this repository into `~/.dotfiles`.
2. Execute the `bootstrap.sh` script:

```bash
cd ~/.dotfiles
./bootstrap.sh
```

## Structure

Each top-level directory is a Stow package:

```
.gitignore                  # Prevents committing unwanted files
bootstrap.sh                # Fedora setup script
git/                        # Git configuration
  .gitconfig                # Main git settings (delta, merge, rebase, aliases)
  .global-gitignore         # Global ignore patterns
starship/                   # Starship prompt config
  .config/starship.toml
vim/                        # Vim configuration
  .vimrc
zsh/                        # Zsh configuration
  .zshrc                    # Main shell config (PATH, plugins, aliases)
  .zsh_plugins.txt          # Antidote plugin list
```

## Machine-Specific Customization

- **Git Identity**: Stored in `~/.gitconfig.local` (e.g., `[user] name = ...` and `email = ...`). Automatically prompted during bootstrap.
- **Shell Overrides**: Stored in `~/.zshrc.local` (e.g., custom paths, machine-specific environment variables). Sourced automatically by `.zshrc` if present.

## Stow Packages

```bash
stow -R git starship vim zsh
```
