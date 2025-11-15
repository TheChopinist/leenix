{
  config,
  pkgs,
  inputs,
  ...
}: {
  system.stateVersion = "25.05";

  imports = [
    ./hardware-configuration.nix

    # modules
    ./modules/system.nix
    # ./modules/user.nix
    ./modules/de.nix
    ./modules/graphics.nix
    ./modules/audio.nix
  ];

  # ============================
  #         TEMPORARY
  # ============================

  # No reaction in hyprland
  boot.kernelParams = [
    "initcall_blacklist=simpledrm_platform_driver_init"
  ];

  # ============================
  #         APPLICATIONS
  # ============================

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    fira-code
    fastfetch
    pfetch-rs
    git
    nix-output-monitor
    nodejs
    alejandra
  ];

  fonts.fontconfig.defaultFonts.monospace = ["Fira Code"];

  # ============================
  #          GAMING
  # ============================

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = [pkgs.proton-ge-bin];
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  programs.gamemode.enable = true;

  /*
    systemd.services.nix-gc-on-shutdown = {
    description = "Run Nix GC before shutdown";
    wantedBy = ["shutdown.target"];
    script = "nix-collect-garbage --delete-old --keep 10";
    serviceConfig.Type = "oneshot";
  };
  */

  nix.settings.auto-optimise-store = true;

  users.users.lee = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "video"];
  };
}
