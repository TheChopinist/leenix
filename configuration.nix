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
    inputs.home-manager.nixosModules.default
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
  #         USER SETTINGS
  # ============================

  users.users.lee = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "lee" = import ./home.nix;
    };
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