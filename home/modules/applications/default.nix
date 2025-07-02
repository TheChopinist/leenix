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
    protonup
    kitty
    vscodium
    easyeffects
    cmatrix
    cava
    btop
    ranger
    lutris

    tty-clock
    cbonsai

    isoimagewriter
  ];
}
