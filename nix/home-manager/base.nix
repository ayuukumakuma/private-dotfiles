{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    curl
    wget
    ghq
    _1password-cli
    nil
    nixd
    fishPlugins.z
    fishPlugins.tide
    fishPlugins.pisces
    fishPlugins.puffer
    fishPlugins.fish-bd
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""
    '';
    shellAbbrs = {
      g = "git";
      co = "codex";
      reload = "exec fish -l";
      c = "clear";
    };
  };

  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      color = {
        ui = true;
      };
      core = {
        editor = "nvim";
        diff = "delta";
      };
      merge = {
        conflictStyle = "zdiff3";
      };
      commit = {
        gpgsign = true;
      };
      push = {
        autoSetupRemote = true;
      };
      delta = {
        navigate = true;
        dark = true;
        side-by-side = true;
        line-numbers = true;
      };
      init.defaultBranch = "main";
      pull.ff = "only";
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
        program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
      include = {
        path = "~/.config/git/config.local";
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin Frappe";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "html"
      "catppuccin"
      "catppuccin-icons"
      "toml"
      "git-firefly"
    ];
  };

  programs.gh.enable = true;

  programs.fd = {
    enable = true;
    hidden = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    colors = "auto";
    git = true;
    icons = "always";
    theme = "catppuccin-frappe";
  };

  programs.jq.enable = true;
  programs.ripgrep.enable = true;
}
