{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/go/src/github.com/alexbarksdale/dotfiles";
in

{
  home.username = "alexbarksdale";
  home.homeDirectory = "/Users/alexbarksdale";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    ripgrep
    jq
    kubectl
    neovim
  ];

  home.sessionVariables.EDITOR = "nvim";

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bun.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user = {
        name = "Alex Barksdale";
        email = "alx.barksdale@gmail.com";
      };

      url."git@github.com:".insteadOf = "https://github.com/";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };

    shellAliases = {
      k = "kubectl";
      api = "kubectl -n api";
      evp = "kubectl -n event-processor";
    };

    profileExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';

    envExtra = ''
      export VOLTA_HOME="$HOME/.volta"
      export PATH="$VOLTA_HOME/bin:$PATH"

      if [ -s "$HOME/.cargo/env" ]; then
        . "$HOME/.cargo/env"
      fi
    '';

    initContent = ''
      export GOPATH="$HOME/go"
      export GOPRIVATE="github.com/pebbl-app"
      export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

      if [ -d "/opt/homebrew/opt/openjdk/bin" ]; then
        export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
      fi

      if [ -d "/opt/homebrew/share/google-cloud-sdk/bin" ]; then
        export PATH="/opt/homebrew/share/google-cloud-sdk/bin:$PATH"
      fi

      if command -v pyenv >/dev/null 2>&1; then
        export PYENV_ROOT="$HOME/.pyenv"
        if [ -d "$PYENV_ROOT/bin" ]; then
          export PATH="$PYENV_ROOT/bin:$PATH"
        fi
        eval "$(pyenv init - zsh)"
      fi

      if command -v rbenv >/dev/null 2>&1; then
        eval "$(rbenv init -)"
      fi

      if [ -d "$HOME/.local/bin" ]; then
        export PATH="$HOME/.local/bin:$PATH"
      fi

      if command -v direnv >/dev/null 2>&1; then
        eval "$(direnv hook zsh)"
      fi

      if command -v zoxide >/dev/null 2>&1; then
        eval "$(zoxide init zsh)"
      fi

      if [ -d "$HOME/.local/share/bob/nvim-bin" ]; then
        export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
      fi
    '';
  };

  home.file.".config/ghostty".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/ghostty";

  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/nvim";

  home.file.".tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/tmux/tmux.conf";

  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";

  home.file.".codex/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
}
