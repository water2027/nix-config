{
  pkgs,
  inputs,
  lib,
  config,
  username,
  ...
}:

{
  nix.extraOptions = ''
    !include ${config.sops.secrets.github_token_nix.path}
  '';

  imports = [
    ../nix/common.nix
    ../system/packages.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    ../../secrets/sops.nix
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

  environment.enableAllTerminfo = true;

  environment.sessionVariables = {
    EDITOR = "vim";
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    unrar
  ];
}
