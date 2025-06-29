{pkgs, ...}: {
  programs.eww = {
    enable = true;
    package = pkgs.eww;
    configDir = ./eww-config; # Points to files in your NixOS folder
  };

  # This creates the proper symlink in ~/.config/eww
  home.file.".config/eww" = {
    source = ./eww-config;
    recursive = true;
  };

  home.packages = with pkgs; [
    jq
    figlet
    libnotify
  ];
}
