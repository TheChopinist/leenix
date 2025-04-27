{pkgs, ...}: let
  # Properly import the wallpaper file
  wallpaper = ./wallpapers/72-KkVUdIw.jpg;
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;

      # Use the imported wallpaper path
      preload = "${wallpaper}";
      wallpaper = "," + "${wallpaper}";
    };
  };
}
