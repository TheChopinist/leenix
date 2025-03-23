/*

██████╗  █████╗ ███████╗███████╗    ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗
██╔══██╗██╔══██╗██╔════╝██╔════╝    ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║
██████╔╝███████║███████╗█████╗      ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║
██╔══██╗██╔══██║╚════██║██╔══╝      ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║
██████╔╝██║  ██║███████║███████╗    ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗
╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝    ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝
*/
/*

Todo: Modularize DE Packages and stuff
Install maybe? https://nixos.wiki/wiki/Gamemode
https://github.com/Gerg-L/spicetify-nix/

Github: https://github.com/TheChopinist/leenux
Package Search: https://search.nixos.org/
Text Generator: https://www.fancytextpro.com/BigTextGenerator
Tutorials used: https://youtu.be/a67Sv4Mbxmc
*/

{
  description = "Leenix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.leenix = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./nixos/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
