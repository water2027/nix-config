{
  pkgs,
  inputs,
  lib,
  username,
  ...
}:

{
  imports = [
    ../nix/common.nix
    ../system/packages.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  systemd.tmpfiles.rules = [
    "d /home/${username}/.ssh 0700 ${username} users - -"
  ];

  time.timeZone = lib.mkDefault "Asia/Shanghai";
  i18n.defaultLocale = lib.mkDefault "zh_CN.UTF-8";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  nix.settings.auto-optimise-store = true;

  environment.enableAllTerminfo = false;

  environment.sessionVariables = {
    EDITOR = "vim";
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    unrar
  ];
}
