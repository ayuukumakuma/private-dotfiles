{
  config,
  ...
}:

let
  dotfilesRoot = "/Users/ayuu/ghq/github.com/ayuukumakuma/private-dotfiles";
  oos = config.lib.file.mkOutOfStoreSymlink;
in
{
  xdg.enable = true;

  xdg.configFile = {
    rift = {
      source = oos "${dotfilesRoot}/rift";
    };
    ghostty = {
      source = oos "${dotfilesRoot}/ghostty";
    };
    "zed/settings.json".source = oos "${dotfilesRoot}/zed/settings.json";
  };

  home.file = {
    ".agents".source = oos "${dotfilesRoot}/agents";
    ".codex/config.toml".source = oos "${dotfilesRoot}/codex/config.toml";
    ".config/git/config.local".source = oos "${dotfilesRoot}/locals/git/config.local";
  };
}
