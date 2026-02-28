{ ... }:

{
  homebrew = {
    enable = true;
    greedyCasks = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    taps = [
      "acsandmann/tap" # rift
    ];

    brews = [
      {
        name = "rift";
        start_service = true;
      }
      "mas"
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
    ];

    masApps = {
      "Klack" = 6446206067;

      # Safari Extensions
      "1Password for Safari" = 1569813296;
      "uBlock Origin Lite" = 6745342698;
    };
  };
}
