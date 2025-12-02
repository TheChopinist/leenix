{pkgs, ...}: {
  imports = [
    ./wofi/default.nix
    ./waybar/default.nix
    ./kitty/default.nix
    ./dunst/default.nix
    ./hyprpaper/default.nix
  ];

  # Required environment packages
  home.packages = with pkgs; [
    librewolf
    brave
    (discord.override {
      # withOpenASAR = true;
      withVencord = true;
    })
    vulkan-loader
    protonup-ng
    kitty
    vscodium
    obs-studio
    easyeffects
    cmatrix
    cava
    btop
    ranger
    musescore

    tty-clock
    cbonsai
    zed-editor

    isoimagewriter
  ];
}
