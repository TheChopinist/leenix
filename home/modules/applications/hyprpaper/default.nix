{pkgs, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;

      preload = ./wallpapers/wallpaper.jpg;
      wallpaper = ",./wallpapers/wallpaper.jpg";
    };
  };
}
