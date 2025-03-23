{ config, pkgs, ... }:

{
  users.users.lee = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      "lee" = import ../../home/home.nix;
    };
  };
}
