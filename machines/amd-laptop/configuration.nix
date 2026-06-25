{
  pkgs,
  inputs,
  username,
  hostname,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/linux-laptop/system.nix
    # ../../modules/programs/waydroid.nix
  ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv4.conf.all.forwarding" = 1;
  };

  fileSystems."/".options = [ "compress=zstd" ];
  fileSystems."/home".options = [ "compress=zstd" ];

  services.keyd.keyboards.default.settings.main = {
    kpslash = "backslash";
  };

  home-manager.users.${username}.imports = [
    ../../profiles/linux-laptop/home.nix
    ./home.nix
  ];

  networking.hostName = hostname;

  environment.systemPackages = with pkgs; [
  ];

  fonts.packages = with pkgs; [
  ];

  system.stateVersion = "25.11";
}
