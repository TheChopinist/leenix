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

  programs.home-manager.enable = true;
}
