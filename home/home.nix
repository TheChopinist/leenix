{ config, pkgs, ... }:

{
  home.username = "lee";
  home.homeDirectory = "/home/lee";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = [
    # pkgs.hello

    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.kitty = {
    enable = true;
    settings = {
      font_size = 12;
      font_family = "Fira Code";
      background_opacity = "0.7";
      confirm_os_window_close = 0;
    };
  };

  programs.home-manager.enable = true;
}
