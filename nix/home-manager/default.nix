{ username, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm-backup";
  home-manager.sharedModules = [
    ./base.nix
    ./config-links.nix
  ];
  home-manager.users.${username} = import ../homes/${username}/default.nix;
}
