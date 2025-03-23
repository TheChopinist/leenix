{
  config,
  pkgs,
  inputs,
  ...
}: {
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

    waybar
    wofi
    dunst
    hyprpaper
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

  # dont have sudo rn? !!!! REMOVE ON NEW PC SINCE I MESSED UP HERE ONCE
  security.sudo.enable = true;

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      "lee" = import ../home/home.nix;
    };
  };
}
