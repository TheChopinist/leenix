{pkgs, ...}: {
  imports = [
    ./waybar/toggle-waybar.nix
    ./eww/start.nix
  ];
}
