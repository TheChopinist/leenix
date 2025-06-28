{pkgs, ...}: {
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./eww-config;
  };

  xdg.configFile."eww-config" = {
    source = ./eww-config;
    recursive = true;
  };

  home.packages = with pkgs; [
    jq
    figlet
  ];
}
