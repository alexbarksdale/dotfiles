# dotfiles

My personal configuration files.

## What's included

| Config | Path on system | Description |
|--------|---------------|-------------|
| tmux | `~/.tmux.conf` | Tmux config with catppuccin theme, session persistence |
| ghostty | `~/.config/ghostty/` | Ghostty terminal config + catppuccin themes |
| nvim | `~/.config/nvim/` | Neovim config (kickstart.nvim based) |
| iterm2 | — | iTerm2 profile export |

## Dependencies

### Tmux

- [tmux](https://github.com/tmux/tmux)
- [TPM](https://github.com/tmux-plugins/tpm) (Tmux Plugin Manager) — install first, then press `prefix + I` inside tmux to install plugins

```sh
# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Plugins (installed automatically via TPM):
- [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) — save/restore sessions
- [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) — automatic session saving
- [catppuccin/tmux](https://github.com/catppuccin/tmux) — theme (frappe flavor)

### Ghostty

- [Ghostty](https://ghostty.org/) — install the app, then symlink/copy the config

### Neovim

- [Neovim](https://neovim.io/) (>= 0.9)

## Setup

```sh
# Clone
git clone https://github.com/alexbarksdale/dotfiles.git

# Tmux
cp .tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install tmux plugins:
# 1. Open tmux
# 2. Press prefix + I (capital I) to install plugins
# TPM will clone: tmux-resurrect, tmux-continuum, catppuccin/tmux

# Ghostty
mkdir -p ~/.config/ghostty
cp -r ghostty/* ~/.config/ghostty/

# Neovim
mkdir -p ~/.config/nvim
cp -r nvim/* ~/.config/nvim/
```
