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
    ../../modules/nixos/common.nix
    ../../modules/nixos/zram.nix
    ../../modules/nixos/swap.nix
    ../../modules/nixos/user.nix
    ../../modules/programs/vm.nix
    # ../../modules/programs/waydroid.nix
    ../../modules/programs/v2raya.nix
    ../../modules/programs/thunar.nix
    ../../modules/programs/steam.nix
    ../../modules/programs/snapper.nix
    ../../modules/programs/zerotier.nix
    ../../modules/desktop/common/sddm.nix
    ../../modules/desktop/hyprland/system.nix
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

  networking.firewall.checkReversePath = false;

  fileSystems."/".options = [ "compress=zstd" ];
  fileSystems."/home".options = [ "compress=zstd" ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.blueman.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.displayManager.defaultSession = "hyprland";

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          kpslash = "backslash";
        };
      };
    };
  };

  home-manager = {
    sharedModules = [
      inputs.nixvim.homeModules.nixvim
    ];
    extraSpecialArgs = { inherit inputs username; };
    users.${username} = import ./home.nix;
  };

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  services.openssh.enable = true;

  programs.zsh.enable = true;
  users.users.${username}.shell = pkgs.zsh;

  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    nil
    mpv
    ffmpeg
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

  services.xserver.excludePackages = [ pkgs.xterm ];

  system.stateVersion = "25.11";
}
