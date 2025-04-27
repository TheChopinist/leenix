{
  pkgs,
  lib,
  config,
  ...
}: let
  wallpapersStorePath = builtins.path {
    path = ./wallpapers;
    name = "hyprpaper-wallpapers";
  };

  wallpaperScript = pkgs.writeShellScriptBin "hyprpaper-randomizer" ''
    WALLPAPER_DIR="${config.home.homeDirectory}/.wallpapers"
    MONITORS=($(hyprctl monitors | grep -oP 'Monitor \K\S+'))
    SELECTED_WALL=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload "$SELECTED_WALL"
    for monitor in "''${MONITORS[@]}"; do
      hyprctl hyprpaper wallpaper "$monitor,$SELECTED_WALL"
    done
  '';
in {
  home.file.".wallpapers" = {
    source = wallpapersStorePath;
    recursive = true;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
    };
  };

  systemd.user.services.wallpaper-randomizer = {
    Unit.After = ["graphical-session.target"];
    Service.ExecStart = "${wallpaperScript}/bin/hyprpaper-randomizer";
  };

  systemd.user.timers.wallpaper-randomizer = {
    Timer.OnUnitActiveSec = "1h";
    Install.WantedBy = ["timers.target"];
  };
}
