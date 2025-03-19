{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
  nixosConfigurations.leenux = nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
      hardwareConfig = ./hardware-configuration.nix;  # Pass the file as an argument
    };
    modules = [
      ./configuration.nix
      inputs.home-manager.nixosModules.default
    ];
  };
};
}
