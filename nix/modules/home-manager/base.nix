{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    eza
    fzf
    zoxide
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ".." = "cd ..";
      gs = "git status";
      ll = "eza -la";
      ls = "eza";
    };

    initContent = ''
      eval "$(zoxide init zsh)"
    '';
  };

  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
