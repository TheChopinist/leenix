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

  Github: https://github.com/TheChopinist/leenux
  Package Search: https://search.nixos.org/
  Text Generator: https://www.fancytextpro.com/BigTextGenerator
  Tutorials used: https://youtu.be/a67Sv4Mbxmc

*/

{ config, pkgs, inputs, ... }: {

  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default

    # modules
    ./modules/system.nix
    # ./modules/user.nix
    ./modules/graphics.nix
    ./modules/audio.nix
  ];

  # ============================
  #    DESKTOP ENVIRONMENT
  # ============================

  services.displayManager.sddm.enable = true;

  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    plasma-browser-integration
    konsole
    kate
    dolphin
  ];

  programs.hyprland.enable = true;

  # ============================
  #         APPLICATIONS
  # ============================

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    librewolf
    fira-code
    fastfetch
    discord
    git
    vulkan-loader
    protonup
    kitty
    vscodium
    nautilus

    waybar
    wofi
    dunst
    hyprpaper
  ];

  fonts.fontconfig.defaultFonts.monospace = [ "Fira Code" ];

  # ============================
  #          GAMING
  # ============================

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 7d";
  };

  users.users.lee = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };


  # dont have sudo rn?
  security.sudo.enable = true;

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      "lee" = import ../../home/home.nix;
    };
  };
}