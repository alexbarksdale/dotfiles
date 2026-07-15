{ ... }:

{
  # Determinate already manages the Nix daemon, so nix-darwin shouldn't.
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin"; # use x86_64-darwin for Intel CPU

  system.primaryUser = "alexbarksdale";
  users.users.alexbarksdale = {
    home = "/Users/alexbarksdale";
  };
  system.stateVersion = 6;
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2;          # fast key repeat
      InitialKeyRepeat = 15;  # short delay before repeat
      _HIHideMenuBar = false;  # auto-hide the menu bar
      AppleShowAllExtensions = true;
    };
    dock.autohide = true;
    finder.FXPreferredViewStyle = "Nlsv";  # list view by default
    finder.CreateDesktop = true;          # clean desktop
    trackpad.Clicking = true;              # tap to click
  };
  nix-homebrew = {
    enable = true;
    autoMigrate = true;
    user = "alexbarksdale";
  };
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";  # remove anything not listed here
    onActivation.autoUpdate = true;
    onActivation.extraFlags = [ "--force" ];
    taps = [
      {
        name = "hashicorp/tap";
        trusted = true;
      }
    ];
    brews = [
      "bob"
      "cocoapods"
      "direnv"
      "doctl"
      "fastlane"
      "fzf"
      "hashicorp/tap/terraform"
      "gh"
      "go"
      "golang-migrate"
      "openjdk"
      "gradle"
      "helm"
      "kubeconform"
      "kubectx"
      "openjdk@21"
      "pandoc"
      "pipx"
      "postgresql@14"
      "protobuf"
      "pyenv"
      "rbenv"
      "ripgrep"
      "shellcheck"
      "sqlc"
      "tmux"
      "uv"
      "xcode-build-server"
      "xcodegen"
      "zig"
      "zoxide"
    ];
    casks = [
      "codex"
      "ghostty"
      "mactex-no-gui"
      "ngrok"
    ];
  };
}
