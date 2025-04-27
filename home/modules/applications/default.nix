{pkgs, ...}: {
  imports = [
    ./wofi/default.nix
    ./waybar/default.nix
    ./kitty/default.nix
    ./dunst/default.nix
    ./hyprpaper/default.nix
  ];
}
