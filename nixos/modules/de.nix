{ config, pkgs, ... }:

{

  # plasma

  # services.displayManager.sddm.enable = true;

  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    plasma-browser-integration
    konsole
    kate
  ];

  # hyprland

  programs.hyprland.enable = true; # enable Hyprland

}