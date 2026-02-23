{
  config,
  ...
}:

let
  dotfilesRoot = "/Users/ayuu/dotfiles";
  oos = config.lib.file.mkOutOfStoreSymlink;
in
{
  xdg.enable = true;

  xdg.configFile = {
    rift = {
      source = oos "${dotfilesRoot}/rift";
    };
  };

  home.file = {
    ".agents".source = oos "${dotfilesRoot}/agents";
  };
}
