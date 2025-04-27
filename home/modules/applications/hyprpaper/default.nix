{
  pkgs,
  lib,
  ...
}: let
  # Get all wallpaper files from the wallpapers directory
  wallpapers = lib.cleanSourceWith {
    src = ./wallpapers;
    filter = name: type:
      type == "directory" || lib.strings.hasSuffix ".jpg" name || lib.strings.hasSuffix ".png" name;
  };

  # Script to randomly select and set a wallpaper
  randomWallpaperScript = pkgs.writeShellScriptBin "hyprpaper-random" ''
    WALLPAPERS=(${toString wallpapers}/*)
    SELECTED_WALL=''${WALLPAPERS[$RANDOM % ''${#WALLPAPERS[@]}]}

    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload "$SELECTED_WALL"
    hyprctl hyprpaper wallpaper ",''${SELECTED_WALL}"
  '';
in {
  # Systemd service to run at startup and periodically
  systemd.user.services.hyprpaper-random = {
    Unit = {
      Description = "Random Hyprpaper Wallpaper";
      After = ["graphical-session.target" "hyprpaper.service"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${randomWallpaperScript}/bin/hyprpaper-random";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };

  systemd.user.timers.hyprpaper-random = {
    Unit.Description = "Timer for random Hyprpaper wallpapers";
    Timer = {
      OnBootSec = "10s";
      OnUnitActiveSec = "1h";
      Unit = "hyprpaper-random.service";
    };
    Install.WantedBy = ["timers.target"];
  };

  # Hyprpaper configuration
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
    };
  };
}
