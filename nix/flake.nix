{
  description = "Declarative macOS setup for ayuu";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nix-darwin, home-manager, ... }:
    let
      system = "aarch64-darwin";
      username = "ayuu";
    in
    {
      darwinConfigurations.ayuu-mac = nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = {
          inherit inputs username;
        };
        modules = [
          ./nix-darwin/base.nix
          ./nix-darwin/homebrew.nix
          home-manager.darwinModules.home-manager
          ./home-manager/default.nix
          ./host.nix
        ];
      };
    };
}
