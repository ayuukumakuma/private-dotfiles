{ config, ... }:

{
  xdg.configFile."rift/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dev/rift/config.toml";
}
