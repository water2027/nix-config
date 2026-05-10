{ config, pkgs, inputs, username, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/common.nix
    ];

  home-manager = {
    extraSpecialArgs = { inherit inputs username; };
    users.${username} = import ./home.nix;
  };

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
  };

  networking.hostName = "linux-dev"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # ssh

  programs.zsh.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # nixpkgs.config.allowUnfree = true;

  # 如果需要vscode远程连接
  # services.openssh.enable = true;
  # programs.nix-ld.enable = true;
  system.stateVersion = "25.11";
}
