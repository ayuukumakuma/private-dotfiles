{ lib, pkgs, username, ... }:

{
  # Nix installation/daemon is managed outside nix-darwin (via nix-installer).
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "1password-cli"
    ];

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.fish;
  };

  # Required when login shell is fish; nix-darwin asserts this and configures fish paths/shell registration.
  programs.fish.enable = true;

  fonts.packages = with pkgs; [
    hackgen-nf-font
  ];

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
