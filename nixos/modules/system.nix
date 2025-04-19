{
  config,
  pkgs,
  ...
}: {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  /*
    boot.loader = {
      efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot";  # Adjust if your EFI partition differs
      };
      grub = {
          enable = true;
          efiSupport = true;
          devices = [ "nodev" ];       # Required for UEFI installations
          useOSProber = true;          # For detecting other OSes like Windows
      };
  };
  */

  networking.hostName = "leenux";
  time.timeZone = "Europe/Zurich";

  # ============================
  #      LOCALIZATION & INPUT
  # ============================

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_CH.UTF-8";
    LC_IDENTIFICATION = "de_CH.UTF-8";
    LC_MEASUREMENT = "de_CH.UTF-8";
    LC_MONETARY = "de_CH.UTF-8";
    LC_NAME = "de_CH.UTF-8";
    LC_NUMERIC = "de_CH.UTF-8";
    LC_PAPER = "de_CH.UTF-8";
    LC_TELEPHONE = "de_CH.UTF-8";
    LC_TIME = "de_CH.UTF-8";
  };

  services.xserver = {
    enable = true;
    xkb.layout = "ch";
  };

  console.keyMap = "sg";

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
