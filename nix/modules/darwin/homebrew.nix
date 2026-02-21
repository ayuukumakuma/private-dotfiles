{ ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };

    brews = [
      "pcre2"
      "ripgrep"
    ];

    casks = [
      "1password"
      "codex"
    ];

    masApps = { };
  };
}
