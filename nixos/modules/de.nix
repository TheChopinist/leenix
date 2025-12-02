{
  config,
  pkgs,
  ...
}: {
  services.displayManager.ly.enable = true;

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
      installPhase =
        oldAttrs.installPhase
        + ''
          wrapProgram $out/bin/Discord \
            --add-flags "--disable-gpu-compositing"
        '';
    }))
  ];
}
