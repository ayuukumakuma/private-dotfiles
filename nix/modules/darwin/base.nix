{ pkgs, username, ... }:

{
  # Determinate manages Nix installation/daemon; disable nix-darwin's Nix management.
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.${username}.home = "/Users/${username}";

  environment.systemPackages = with pkgs; [
    bat
    curl
    fd
    git
    jq
    ripgrep
    tree
    wget
  ];

  programs.zsh.enable = true;

  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    stateVersion = 4;
    primaryUser = username;

    defaults = {
      dock = {
        autohide = true;
        "mru-spaces" = false;
        "show-recents" = false;
      };

      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "clmv";
        ShowPathbar = true;
      };

      NSGlobalDomain = {
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
      };

      trackpad = {
        Clicking = true;
      };
    };
  };
}
