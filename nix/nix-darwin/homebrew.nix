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
      "1password"
      "codex"
      "raycast"
      "altserver"
    ];

    masApps = {
      "Klack" = 6446206067;
    };
  };
}
