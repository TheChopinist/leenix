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

  # ============================
  #         SYSTEM SETUP
  # ============================

  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "leenux";
  time.timeZone = "Europe/Zurich";

  # ============================
  #      LOCALIZATION & INPUT
  # ============================

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_CH.UTF-8";
    LC_IDENTIFICATION = "de_CH.UTF-8";
    LC_MEASUREMENT = "de_CH.UTF-8";
    LC_MONETARY = "de_CH.UTF-8";
    LC_NAME = "de_CH.UTF-8";
    LC_NUMERIC = "de_CH.UTF-8";
    LC_PAPER = "de_CH.UTF-8";
    LC_TELEPHONE = "de_CH.UTF-8";
    LC_TIME = "de_CH.UTF-8";
  };

  services.xserver = {
    enable = true;
    xkb.layout = "ch";
  };

  console.keyMap = "sg";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
  ];

  programs.hyprland.enable = true;


  # ============================
  #          AUDIO
  # ============================

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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

  # ============================
  #         USER SETTINGS
  # ============================

  users.users.lee = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };

  # ============================
  #         GRAPHICS
  # ============================

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };


  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 7d";
};
}