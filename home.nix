{ config, pkgs, inputs, ... }: 

{
  home.username = "lee";
  home.homeDirectory = "/home/lee";

  # ============================
  #    DESKTOP ENVIRONMENT
  # ============================

  # Use `home` instead of `environment`
  home.packages = with pkgs; [
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

  # Plasma 6 configuration
  services.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    plasma-browser-integration
    konsole
    kate
  ];

  programs.hyprland.enable = true;

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

  programs.gamemode.enable = true;

  # ============================
  #         SESSION VARIABLES
  # ============================

  home.sessionVariables = {
    BROWSER = "librewolf";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  # ============================
  #         KITTY CONFIG
  # ============================

  programs.kitty = {
    enable = true;
    settings = {
      font_size = 12;
      font_family = "Fira Code";
      background_opacity = "0.5";
      confirm_os_window_close = 0;
    };
  };

  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}