{pkgs, ...}: {
  # Copy the wallpaper to a reliable location
  home.file.".config/hypr/wallpaper.jpg".source = ./wallpapers/wallpaper.jpg;

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = "~/.config/hypr/wallpaper.jpg";
      wallpaper = ",~/.config/hypr/wallpaper.jpg";
    };
  };
}
