{
  description = "Ilya config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./hosts/nixos

        ./modules/services/pipewire.nix
        ./modules/services/bluetooth.nix

        home-manager.nixosModules.home-manager

        {
          home-manager.users.ilya = import ./home/ilya;
        }
      ];
    };
  };
}
