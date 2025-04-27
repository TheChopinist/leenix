{pkgs, ...}: let
  # 1. First copy the wallpaper to a known location
  wallpaper = pkgs.runCommand "wallpaper" {} ''
    mkdir -p $out
    cp ${./wallpaper.jpg} $out/wallpaper.jpg
  '';
in {
  # 2. Then configure hyprpaper to use it
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = "${wallpaper}/wallpaper.jpg";
      wallpaper = ",${wallpaper}/wallpaper.jpg";
    };
  };
}
