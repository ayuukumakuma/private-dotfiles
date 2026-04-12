{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    curl
    wget
    nil
    nixd
    macism
    jnv
    just
    github-copilot-cli
    tmux
    ghq
    fishPlugins.z
    fishPlugins.tide
    fishPlugins.pisces
    fishPlugins.puffer
    fishPlugins.fish-bd
    (callPackage ../pkgs/site2skill.nix { })
  ];

  programs.neovim.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""
    '';
    functions = {
      __ghq_fzf_cd = ''
        set -l preview_cmd 'set -l repo {}; set -l readme_md "$repo/README.md"; set -l readme "$repo/README"; if test -f "$readme_md"; bat --style=plain --color=always --language=markdown "$readme_md"; else if test -f "$readme"; bat --style=plain --color=always --language=markdown "$readme"; else git -C "$repo" remote -v | bat --style=plain --color=always --language=gitconfig; end'
        set -l selected_repo (ghq list --full-path | fzf --height=80% --layout=reverse --preview "$preview_cmd")

        if test -n "$selected_repo"
          cd "$selected_repo"
          commandline -f repaint
        end
      '';
      fish_user_key_bindings = ''
        bind \cg __ghq_fzf_cd
      '';
    };
    shellAbbrs = {
      g = "git";
      co = "codex";
      oc = "opencode";
      reload = "exec fish -l";
      c = "clear";
      j = "just";
      cop = "copilot";
      copm = "copilot --model gpt-5.4-mini";
      tm = "tmux";
    };
  };

  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      alias = {
        a = "add";
        c = "commit";
        ps = "push";
        p = "pull";
        f = "fetch";
      };
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

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
    flavors = {
      catppuccin-latte = "${
        pkgs.fetchFromGitHub {
          owner = "yazi-rs";
          repo = "flavors";
          rev = "9511cb09cadcbf57e39a46b06a52d00957177175";
          hash = "sha256-3RR8mi7CcVMDMitdTdaonFmfAIkeOzWK/CVKQmomIhE=";
        }
      }/catppuccin-latte.yazi";
    };
    settings = {
      opener = {
        edit = [
          {
            run = "zed --wait %s";
            block = true;
            for = "unix";
          }
        ];
      };
    };
    theme = {
      flavor = {
        dark = "catppuccin-latte";
        light = "catppuccin-latte";
      };
    };
    extraPackages = with pkgs; [
      file
      ffmpeg
      poppler
      zoxide
      resvg
      imagemagick
      p7zip
    ];
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin Latte";
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
      "tombi"
      "kconfig"
      "just"
      "swift"
      "package-swift-lsp"
      "editorconfig"
      "tmux"
    ];
    userSettings = {
      "agent_servers" = {
        "opencode" = {
          "type" = "registry";
        };
      };
      "vim_mode" = true;
      "autosave" = {
        "after_delay" = {
          "milliseconds" = 1000;
        };
      };
      "tab_size" = 2;
      "buffer_font_family" = "HackGen Console NF";
      "icon_theme" = "Catppuccin Latte";
      "telemetry" = {
        "diagnostics" = false;
        "metrics" = false;
      };
      "session" = {
        "trust_all_worktrees" = true;
      };
      "project_panel" = {
        "button" = false;
      };
      "git_panel" = {
        "button" = false;
      };
      "outline_panel" = {
        "button" = false;
      };
      "collaboration_panel" = {
        "button" = false;
      };
      "search" = {
        "button" = false;
      };
      "terminal" = {
        "button" = false;
      };
      "notification_panel" = {
        "button" = false;
      };
      "agent" = {
        "button" = false;
      };
      "tab_bar" = {
        "show_nav_history_buttons" = false;
        "show_tab_bar_buttons" = false;
      };
      "status_bar" = {
        "cursor_position_button" = false;
      };
      "toolbar" = {
        "breadcrumbs" = false;
        "quick_actions" = false;
        "selections_menu" = false;
        "agent_review" = false;
        "code_actions" = false;
      };
      "ui_font_size" = 16;
      "buffer_font_size" = 13;
      "theme" = "Catppuccin Latte Transparent";
      "edit_predictions" = {
        "provider" = "copilot";
        "mode" = "eager";
      };
    };
    themes.catppuccin-transparent = ./zed/theme/catppuccin-transparent.json;
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
    theme = "catppuccin-latte";
  };

  programs.jq.enable = true;
  programs.ripgrep.enable = true;
  programs.discord.enable = true;

  programs.sketchybar = {
    enable = true;
    service.enable = true;
    configType = "bash";
    config = {
      source = ./sketchybar;
      recursive = true;
    };
  };

  programs.aerospace.enable = true;
}
