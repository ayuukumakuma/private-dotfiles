{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    curl
    wget
    ghq
    nil
    nixd
    neovim
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

      function __ghq_fzf_cd
        set -l selected_repo (ghq list --full-path | fzf --height=80% --layout=reverse --preview 'if test -f {}/README.md; bat --style=plain --color=always {}/README.md; else if test -f {}/README; bat --style=plain --color=always {}/README; else git -C {} remote -v | bat --style=plain --color=always --language=gitconfig; end; end')

        if test -n "$selected_repo"
          cd "$selected_repo"
          commandline -f repaint
        end
      end

      bind \cg __ghq_fzf_cd
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
  programs.discord.enable = true;
}
