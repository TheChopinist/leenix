{pkgs, ...}: {
  imports = [
    ./waybar/toggle-waybar.nix
    ./eww/greeting.nix
  ];
}
