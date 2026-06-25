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
    ../../modules/nixos/secrets.nix
    ../../modules/nixos/zram.nix
    ../../modules/nixos/swap.nix
    ../../modules/nixos/user.nix
    ../../modules/nixos/virtualisation/libvirt.nix
    ../../modules/nixos/services/v2raya.nix
    ../../modules/nixos/programs/thunar.nix
    ../../modules/nixos/programs/steam.nix
    ../../modules/nixos/services/snapper.nix
    ../../modules/nixos/services/zerotier.nix
    ../../modules/desktop/hyprland/system.nix
  ];

  zramSwap.enable = true;

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

  services.v2raya.enable = true;
  services.zerotierone.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  programs.steam.enable = true;

  programs.thunar.enable = true;
  services.gvfs.enable = true; # 提供回收站、挂载、网络共享等功能
  services.tumbler.enable = true; # 提供图片、视频等文件的缩略图支持

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;

  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  services.dbus.enable = true;
  xdg.portal.enable = true;

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
