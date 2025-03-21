{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {

  imports = [
  ];

  nixpkgs = {
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

    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

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

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
