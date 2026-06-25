{
  pkgs,
  inputs,
  username,
  hostname,
  lib,
  ...
}:

{
  imports = [
    ../../modules/nixos/common.nix
    ../../modules/nixos/zram.nix
    ../../modules/nixos/swap.nix
    ../../modules/nixos/user.nix
    ../../modules/programs/vm.nix
    ../../modules/programs/v2raya.nix
    ../../modules/programs/thunar.nix
    ../../modules/programs/steam.nix
    ../../modules/programs/snapper.nix
    ../../modules/programs/zerotier.nix
    ../../modules/desktop/common/sddm.nix
    ../../modules/desktop/hyprland/system.nix
  ];

  networking.firewall.checkReversePath = false;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = lib.mkDefault pkgs.stdenv.hostPlatform.isx86_64;
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
          capslock = "esc";
        };
      };
    };
  };

  home-manager = {
    backupFileExtension = "hm-backup";
    sharedModules = [
      inputs.nixvim.homeModules.nixvim
    ];
    extraSpecialArgs = { inherit inputs username; };
  };

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
}
