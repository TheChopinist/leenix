{ config, pkgs, ... }:

{

  services.displayManager.ly.enable = true;

  # XFCE
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };
  services.displayManager.defaultSession = "xfce";

  # Plasma
  services.desktopManager.plasma6.enable = true;

  systemd.user.services.kwalletd.enable = false;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    plasma-browser-integration
    konsole
    kate
    khelpcenter
    okular
    kwallet
    print-manager
  ];

  /*
    gwenview
    oxygen
  */

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

    # temp for hyprland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  environment.systemPackages = with pkgs; [
    # VSCodium with GPU compositing disabled
    (vscodium.override {
      commandLineArgs = "--disable-gpu-compositing";
    })

    # Discord with GPU compositing disabled
    (discord.overrideAttrs (oldAttrs: {
      installPhase = oldAttrs.installPhase + ''
        wrapProgram $out/bin/Discord \
          --add-flags "--disable-gpu-compositing"
      '';
    }))
  ];

}
