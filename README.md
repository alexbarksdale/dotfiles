# dotfiles

This repository is my macOS machine configuration.
It uses nix-darwin, Home Manager, and nix-homebrew to make a new Mac reproducible from source-controlled configuration.

## Layout

| Path | Purpose |
|------|---------|
| `flake.nix` | Wires together nixpkgs, nix-darwin, Home Manager, and nix-homebrew. |
| `configuration.nix` | System-level macOS defaults, nix-homebrew setup, Homebrew formulae, and Homebrew casks. |
| `home.nix` | User-level Home Manager packages, shell configuration, Git settings, and symlinks. |
| `home/.config/ghostty` | Ghostty config and themes. |
| `home/.config/nvim` | Neovim config. |
| `home/.config/tmux/tmux.conf` | tmux config source. |
| `home/AGENTS.md` | Shared global agent instructions for Claude and Codex. |
| `iterm2/Main.json` | iTerm2 profile export. |
| `rebuild.sh` | Convenience wrapper around `darwin-rebuild switch`. |

## Managed Files

Home Manager links config files from this repo into the home directory.

| Source in repo | Target on machine |
|----------------|-------------------|
| `home/.config/ghostty` | `~/.config/ghostty` |
| `home/.config/nvim` | `~/.config/nvim` |
| `home/.config/tmux/tmux.conf` | `~/.tmux.conf` |
| `home/AGENTS.md` | `~/.claude/CLAUDE.md` |
| `home/AGENTS.md` | `~/.codex/AGENTS.md` |

The symlinks use `mkOutOfStoreSymlink` so edits in this repository are reflected directly in the live config paths.

## Package Ownership

`configuration.nix` owns system-level Homebrew state through nix-darwin and nix-homebrew.
Homebrew formulae go in `homebrew.brews`.
Homebrew casks go in `homebrew.casks`.
The Homebrew activation cleanup mode is set to `zap`, so unlisted formulae and casks are removed when the system is activated.

`home.nix` owns user-level packages and programs through Home Manager.
This includes packages such as `jq`, `kubectl`, and `neovim`.
It also configures shell behavior, Atuin, Bun, Git, and the dotfile symlinks.

## Setup

Install Nix first.
This configuration assumes Determinate manages the Nix daemon, so `configuration.nix` sets `nix.enable = false`.

Clone the repository to the path expected by `home.nix`.

```sh
mkdir -p ~/go/src/github.com/alexbarksdale
git clone https://github.com/alexbarksdale/dotfiles.git ~/go/src/github.com/alexbarksdale/dotfiles
cd ~/go/src/github.com/alexbarksdale/dotfiles
```

Review `configuration.nix` and `home.nix` before activating on a new machine.
When ready to apply the configuration, run:

```sh
./rebuild.sh
```

`rebuild.sh` symlinks this repository to `~/.dotfiles` and runs:

```sh
sudo darwin-rebuild switch --flake ~/.dotfiles#mac
```

## Notes

Do not run a rebuild unless you are ready for nix-darwin and Home Manager to change the machine.
Because Homebrew cleanup uses `zap`, anything installed through Homebrew but missing from `configuration.nix` can be removed during activation.
tmux plugins are managed by TPM from inside tmux after the tmux config is linked.
