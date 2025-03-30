{ config, pkgs, ... }:

{

  # Plasma
  services.displayManager.ly.enable = true;
  services.desktopManager.plasma6.enable = true;

  systemd.user.services.kwalletd.enable = false;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    plasma-browser-integration
    konsole
    kate
    khelpcenter
    okular
    kwallet
    print-manager
  ];

  /*
    gwenview
    oxygen
  */

  # Hyprland
  programs.hyprland.enable = true;

}
