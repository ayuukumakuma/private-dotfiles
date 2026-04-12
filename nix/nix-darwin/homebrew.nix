{ ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    taps = [
      "k1LoW/tap" # mo (markdown viewer)
      "anomalyco/tap" # opencode
    ];

    brews = [
      "mas"
      "mo"
      "opencode"
    ];

    casks = [
      "azooKey"
      "codex"
      "raycast"
      "altserver"
      "ghostty"
      "spotify"
      "rekordbox"
      "codex-app"
      "chatgpt"
      "1password"
      "1password-cli"
      "thebrowsercompany-dia"
      "figma"
      "nani"
      "logi-options+"
      "icon-composer"
      "modrinth"
    ];

    masApps = {
      "Klack" = 6446206067;
      "Xcode" = 497799835;

      # Safari Extensions
      "1Password for Safari" = 1569813296;
      "uBlock Origin Lite" = 6745342698;
      "没入型翻訳" = 6447957425;
    };
  };
}
