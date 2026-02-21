{
  description = "Declarative macOS setup for ayuu";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nix-darwin, home-manager, ... }:
    let
      system = "aarch64-darwin";
      username = "ayuu";
    in {
      darwinConfigurations.ayuu-mac = nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = {
          inherit inputs username;
        };
        modules = [
          ./modules/darwin/base.nix
          ./modules/darwin/homebrew.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.sharedModules = [
              ./modules/home-manager/base.nix
            ];
            home-manager.users.${username} = import ./homes/${username}/default.nix;
          }
          ./host.nix
        ];
      };
    };
}
