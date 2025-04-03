{
  config,
  pkgs,
  inputs,
  ...
}: {

  system.stateVersion = "25.05";

  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default

    # modules
    ./modules/system.nix
    # ./modules/user.nix
    ./modules/de.nix
    ./modules/graphics.nix
    ./modules/audio.nix
  ];

  # ============================
  #         TEMPORARY
  # ============================
  
  # No reaction in hyprland
  boot.kernelParams = [
    "initcall_blacklist=simpledrm_platform_driver_init"
  ];
  # dont have sudo rn? !!!! REMOVE ON NEW PC SINCE I MESSED UP HERE ONCE
  security.sudo.enable = true;

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
    easyeffects
    cmatrix
    cava
    btop
    nodejs

    # waybar
    wofi
    dunst
    hyprpaper

    mangohud

    tty-clock
    cbonsai
  ];

  fonts.fontconfig.defaultFonts.monospace = ["Fira Code"];

  # ============================
  #          GAMING
  # ============================

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = [pkgs.proton-ge-bin];
  };
 
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  programs.gamemode.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings.auto-optimise-store = true;

  users.users.lee = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "video"];
  };

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      "lee" = import ../home/home.nix;
    };
  };
}
